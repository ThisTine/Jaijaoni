// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:jaijaoni/services/store/fire_store_service.dart';
// import 'package:jaijaoni/model/debt.model.dart';

// import '../utils/find_debt_by_id.dart';

// class DebtData {
//   final String id;
//   final String username;
//   final int total;
//   DebtData({required this.id, required this.username, required this.total});
// }

// Future<DebtData> getFriends(String deptId) async {
//   try {
//     DocumentSnapshot<Map<String, dynamic>> dept =
//         await FireStoreService.collection.debts.doc(deptId).get();
//     Debts userData = Debts.fromFireStore(dept);
//     Debts debt = await findDebtById(deptId);
    
//     return DebtData(
//         id: debt.debtId, username: debt.username, total: debt.debtTotal);
//   } catch (err) {
//     rethrow;
//   }
// }
