import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Borrowers>> findBorrowsandLenderById(String borrwerId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> borrowerQuery = await FireStoreService
        .collection.borrowers
        .where("lenderUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("borrowerUserId", isEqualTo: borrwerId)
        .where("borrowedTime", isLessThanOrEqualTo: DateTime.now())
        .get();
    List<Borrowers> borrower =
        borrowerQuery.docs.map((e) => Borrowers.fromFireStore(e)).toList();
    return borrower;
  } catch (err) {
    rethrow;
  }
}
