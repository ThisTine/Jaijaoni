import 'package:jaijaoni/model/debt.model.dart';
import '../utils/find_debt_by_id.dart';

class DebtData {
  final String id;
  final String username;
  final double total;
  final List<PayChannels> paych;
  final List<Transactions> transactions;
  DebtData(
      {required this.id,
      required this.username,
      required this.total,
      required this.paych,
      required this.transactions});
}

Future<DebtData> getDebt(String deptId) async {
  try {
    // DocumentSnapshot<Map<String, dynamic>> depts =
    //     await FireStoreService.collection.debts.doc(deptId).get();
    // // Debts userData = Debts.fromFireStore(dept);
    Debts debt = await findDebtById(deptId);

    return DebtData(
        id: debt.debtId,
        username: debt.username,
        total: debt.debtTotal,
        paych: debt.payChannels,
        transactions: debt.transactions);
  } catch (err) {
    rethrow;
  }
}
