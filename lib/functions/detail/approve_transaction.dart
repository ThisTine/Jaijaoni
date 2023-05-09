import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> approveTransaction(
    {required String transactionId, required String debtId}) async {
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
                isApproved: "success",
                errMessage: '')
            : e)
        .toList();

    var borrowerDoc = await FireStoreService.collection.borrowers
        .doc(transaction.borrowId)
        .get();
    Borrowers borrower = Borrowers.fromFireStore(borrowerDoc);

    await FireStoreService.collection.borrowers
        .doc(transaction.borrowId)
        .update({"debtRemaining": borrower.debtRemaining - transaction.amount});

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
