import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> createTransction(
  List<Transactions> req,
  DebtData debts,
) async {
  try {
    List<Map<String, dynamic>> res = req
        .map((e) => {
              "transactionId": e.transactionId,
              "borrowId": e.borrowId,
              "username": e.username,
              "profilePic": e.profilePic,
              "isApproved": e.isApproved,
              "errMessage": e.errMessage,
              "amount": e.amount
            })
        .toList();
    var query = FireStoreService.collection.debts.doc(debts.id);
    await query.update({"transactions": res});
  } catch (err) {
    rethrow;
  }
}
