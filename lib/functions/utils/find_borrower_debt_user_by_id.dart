import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import '../../services/store/fire_store_service.dart';

Future<Borrowers> findborrwerBytwoId(String deptID) async {
  try {
    print(FirebaseAuth.instance.currentUser!.uid);

    QuerySnapshot<Map<String, dynamic>> borrowerQuery = await FireStoreService
        .collection.borrowers
        .where("debtId", isEqualTo: deptID)
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    print("ตรงนี้จ้า");

    Borrowers borrower = Borrowers.fromFireStore(borrowerQuery.docs.first);
    return borrower;
  } catch (err) {
    print("catch3");
    print(FirebaseAuth.instance.currentUser!.uid);
    print(err.toString());
    rethrow;
  }
}
