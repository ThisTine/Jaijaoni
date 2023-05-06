import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/debt.model.dart';
import '../../services/store/fire_store_service.dart';

Future<Debts> findDebtById(String deptID) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> deptDoc =
        await FireStoreService.collection.debts.doc(deptID).get();
    // List<Users> users = usersDoc.docs.map((e) => Users.fromFireStore(e)).toList();
    Debts debt = Debts.fromFireStore(deptDoc);
    return debt;
  } catch (err) {
    rethrow;
  }
}
