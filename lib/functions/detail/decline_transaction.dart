import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> declineTransaction(
    {required String debtId,
    required String transactionId,
    required String reason}) async {
  try {
    var debtDoc = await FireStoreService.collection.debts.doc(debtId).get();
    Debts debt = Debts.fromFireStore(debtDoc);
    List<Transactions> filteredTransactions = debt.transactions
        .where((element) => element.transactionId == transactionId)
        .toList();
    if (filteredTransactions.isEmpty) {
      throw "Transaction not found";
    }
    Transactions transaction = filteredTransactions.first;
    List<Transactions> updatedTransactions = debt.transactions
        .map((e) => e.transactionId == transactionId
            ? Transactions(
                transactionId: transaction.transactionId,
                borrowId: transaction.borrowId,
                username: transaction.username,
                profilePic: transaction.profilePic,
                amount: transaction.amount,
                isApproved: "error",
                errMessage: reason)
            : e)
        .toList();
    await FireStoreService.collection.debts.doc(debtId).update({
      "transactions": updatedTransactions
          .map((e) => {
                "transactionId": e.transactionId,
                "borrowId": e.borrowId,
                "username": e.username,
                "profilePic": e.profilePic,
                "amount": e.amount,
                "isApproved": e.isApproved,
                "errMessage": e.errMessage
              })
          .toList()
    });
  } catch (err) {
    rethrow;
  }
}
