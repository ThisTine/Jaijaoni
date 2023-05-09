import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Borrowers>> findBorrowsByUserId() async {
  try {
    QuerySnapshot<Map<String, dynamic>> borrowerQuery = await FireStoreService
        .collection.borrowers
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("borrowedTime", isLessThanOrEqualTo: DateTime.now())
        .get();
    List<Borrowers> borrower =
        borrowerQuery.docs.map((e) => Borrowers.fromFireStore(e)).toList();
    print(borrower.map((e) => e.debtRemaining).toList());

    return borrower;
  } catch (err) {
    print(err);
    rethrow;
  }
}
