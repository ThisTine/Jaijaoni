import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

final debtStreamProvider =
    StreamProvider.family<Debts, String>((ref, debtId) async* {
  var query = FireStoreService.collection.debts.doc(debtId);
  var userId = FirebaseAuth.instance.currentUser!.uid;
  Users user = await findUserById(userId);
  var snapshots = query.snapshots();
  await for (var snapshot in snapshots) {
    Debts debtsWithData = Debts.fromFireStore(snapshot);
    if (debtsWithData.userId == userId ||
        debtsWithData.borrowersUserId.contains(userId)) {
      if (debtsWithData.userId != userId) {
        yield Debts(
            debtId: debtsWithData.debtId,
            userId: debtsWithData.userId,
            username: debtsWithData.username,
            borrowersUserId: debtsWithData.borrowersUserId,
            debtName: debtsWithData.debtName,
            debtTotal: debtsWithData.debtTotal,
            createTime: debtsWithData.createTime,
            due: debtsWithData.due,
            payChannels: debtsWithData.payChannels,
            transactions: debtsWithData.transactions
                .where((element) => element.username == user.username)
                .toList());
      } else {
        yield debtsWithData;
      }
    } else {
      throw "permission denied : You're not in this debt or this debt doesn't belong to you.";
    }
  }
  // return null;
});
