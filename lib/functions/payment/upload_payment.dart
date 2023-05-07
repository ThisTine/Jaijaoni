import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/payment/create_transction.dart';
import 'package:jaijaoni/functions/payment/get_borrower.dart';
import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/model/debt.model.dart';

class Uploadpay {
  final String borrowId;
  final String username;
  final String profilePic;
  final double amount;
  final String isApproved;
  final String errMessage;
  const Uploadpay(
      {required this.borrowId,
      required this.username,
      required this.profilePic,
      required this.amount,
      required this.isApproved,
      required this.errMessage});
}

Future<void> uploadPayment(String debtId, double amount) async {
  try {
    DebtData debts = await getDebt(debtId);
    BorrowerData borrwer = await getBorrower(debtId);
    Transactions upload = Transactions(
      borrowId: borrwer.id,
      username: borrwer.username,
      profilePic: '',
      isApproved: 'pending',
      errMessage: '',
      amount: amount, transactionId: '',
    );
    createTransction(upload, debts);
    debts = await getDebt(debtId);
    print('ตรงนี้');
    print(debts.transactions.toString());

    // return "asd";
  } catch (err) {
    rethrow;
  }
}
