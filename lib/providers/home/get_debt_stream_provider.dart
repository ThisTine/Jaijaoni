import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

final debtStreamProvider =
    StreamProvider.family<Debts, String>((ref, debtId) async* {
  var query = FireStoreService.collection.debts.doc(debtId);
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var snapshots = query.snapshots();
  await for (var snapshot in snapshots) {
    Debts debtsWithData = Debts.fromFireStore(snapshot);
    if (debtsWithData.userId == userId ||
        debtsWithData.borrowersUserId.contains(userId)) {
      yield debtsWithData;
    } else {
      throw "permission denied : You're not in this debt or this debt doesn't belong to you.";
    }
  }
  // return null;
});
