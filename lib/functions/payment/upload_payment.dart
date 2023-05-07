import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/payment/create_transction.dart';
import 'package:jaijaoni/functions/payment/get_borrower.dart';
import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/model/debt.model.dart';

Future<void> uploadPayment(String debtId, double amount) async {
  try {
    DebtData debts = await getDebt(debtId);
    BorrowerData borrwer = await getBorrower(debtId);
    Transactions upload = Transactions(
        borrowId: FirebaseAuth.instance.currentUser!.uid,
        username: borrwer.username,
        profilePic: '',
        isApproved: 'pending',
        errMessage: '',
        amount: amount);
    createTransction(upload, debts);
    debts = await getDebt(debtId);
    print(debts.transactions.toString());

    // return "asd";
  } catch (err) {
    rethrow;
  }
}
