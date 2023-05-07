import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Borrowers>> findBorrowerByUserId() async {
  try {
    QuerySnapshot<Map<String, dynamic>> bowDoc = await FireStoreService
        .collection.borrowers
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<Borrowers> bows =
        bowDoc.docs.map((e) => Borrowers.fromFireStore(e)).toList();

    return bows;
  } catch (err) {
    rethrow;
  }
}
