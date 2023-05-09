import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import '../../services/store/fire_store_service.dart';

Future<Borrowers> findborrwerBytwoId(String deptID) async {
  try {
    // QuerySnapshot<Map<String, dynamic>> test = await FireStoreService
    //     .collection.borrowers
    //     .where("debtId", isEqualTo: deptID)
    //     .where("borrowerUserId",
    //         isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get();
    QuerySnapshot<Map<String, dynamic>> borrowerQuery = await FireStoreService
        .collection.borrowers
        .where("debtId", isEqualTo: deptID)
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(borrowerQuery.docs.map((e) => e.data()));
    Borrowers borrower = Borrowers.fromFireStore(borrowerQuery.docs.first);
    return borrower;
  } catch (err) {
    print(err);
    rethrow;
  }
}
