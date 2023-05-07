import 'dart:io';

import 'package:jaijaoni/functions/payment/create_transction.dart';
import 'package:jaijaoni/functions/payment/get_borrower.dart';
import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/functions/payment/upload_bill.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:uuid/uuid.dart';

Future<void> uploadPayment(String debtId, double amount, File file) async {
  try {
    var uuid = const Uuid();
    var id = uuid.v4();
    DebtData debts = await getDebt(debtId);
    BorrowerData borrwer = await getBorrower(debtId);
    Transactions upload = Transactions(
      transactionId: id,
      borrowId: borrwer.id,
      username: borrwer.username,
      profilePic: '',
      isApproved: 'pending',
      errMessage: '',
      amount: amount,
    );
    List<Transactions> req = debts.transactions;
    req.add(upload);
    await createTransction(req, debts);
    uploadBill(file, id);
  } catch (err) {
    rethrow;
  }
}
