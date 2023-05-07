import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> createTransction(
  Transactions upload,
  DebtData debts,
) async {
  try {
    var query = FireStoreService.collection.debts.doc(debts.id);
    List<Transactions> up = debts.transactions;
    up.add(upload);
    await query.update({"transactions": up});
    // return query.toString();
  } catch (err) {
    rethrow;
  }
}
