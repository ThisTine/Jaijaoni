import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Debts>> findDebtsByUserId() async {
  try {
    QuerySnapshot<Map<String, dynamic>> debtDoc = await FireStoreService
        .collection.debts
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<Debts> debts = debtDoc.docs.map((e) {
      // print(e.data());
      // print("");
      return Debts.fromFireStore(e);
    }).toList();
    // print(debts.map(
    //     (e) => [e.debtId, e.debtName, e.debtTotal, e.due, e.borrowersUserId]));
    return debts;
  } catch (err) {
    // print(err);
    rethrow;
  }
}
