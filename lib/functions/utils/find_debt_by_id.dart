import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/debt.model.dart';
import '../../services/store/fire_store_service.dart';

Future<Debts> findDebtById(String deptId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> deptDoc =
        await FireStoreService.collection.debts.doc(deptId).get();

    Debts debt = Debts.fromFireStore(deptDoc);

    return debt;
  } catch (err) {
    rethrow;
  }
}
