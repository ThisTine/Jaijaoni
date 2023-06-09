import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';
import 'package:uuid/uuid.dart';

import '../../model/user.model.dart';
import '../../providers/create/create_debt_data_provider.dart';

Future<String> createDebt(CreateDebtData debtData) async {
  try {
    Users lender = await findUserById(FirebaseAuth.instance.currentUser!.uid);
    DateTime dueDate = debtData.dueDate ?? DateTime.now();
    String lenderUserId = FirebaseAuth.instance.currentUser!.uid;
    String lenderUsername = lender.username;

    Map<String, dynamic> debtMap = {
      "userId": lenderUserId,
      "username": lenderUsername,
      "borrowersUserId": debtData.friendList
          .where((element) => element.id != lenderUserId)
          .map((e) => e.id)
          .toList(),
      "debtName": debtData.name,
      "debtTotal": debtData.totalPrice,
      "payChannels": debtData.paymentList
          .where((element) => element.isCheck)
          .map((e) => {"channel": e.channel, "number": e.number})
          .toList(),
      "due": dueDate,
      "createTime": FieldValue.serverTimestamp(),
      "transactions": debtData.friendList
          .where((element) => element.id == lenderUserId)
          .map((e) => {
                "amount": e.price.toDouble(),
                "borrowId": "",
                "errMessage": "",
                "isApproved": "success",
                "transactionId": const Uuid().v4().toString(),
                "username": lender.username,
                "profilePic" : ""
              })
    };

    DocumentReference<Map<String, dynamic>> createdDebt =
        await FireStoreService.collection.debts.add(debtMap);

    List<Map<String, dynamic>> borrowers = debtData.friendList.where((element) => element.id != lenderUserId)
        .map((e) => {
              "debtId": createdDebt.id,
              "lenderUserId": lenderUserId,
              "lenderUsername": lenderUsername,
              "borrowerUserId": e.id,
              "borrowerUsername": e.username,
              "debtTotal": e.price,
              "debtRemaining": e.price,
              "borrowedTime": FieldValue.serverTimestamp(),
              "due": dueDate,
            })
        .toList();

    //  await FireStoreService.collection.borrowers.add();
    WriteBatch batch = FireStoreService.instance.batch();

    for (var element in borrowers) {
      batch.set(FireStoreService.collection.borrowers.doc(), element);
    }

    await batch.commit();

    return createdDebt.id;
  } catch (err) {
    rethrow;
  }
}
