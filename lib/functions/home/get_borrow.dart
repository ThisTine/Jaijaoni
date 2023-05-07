import 'package:jaijaoni/functions/utils/find_borrower_by_user_id.dart';
import 'package:jaijaoni/functions/utils/find_debt_by_id.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/model/debt.model.dart';

Future<List<Map<String, dynamic>>> getBow() async {
  try {
    List<Map<String, dynamic>> lend;
    List<Borrowers> bows = await findBorrowerByUserId();
    List<String> debtId = bows.map((e) => e.debtId).toList();

    List<Debts> debts = bows.map((e) => (findDebtById(e.debtId))).toList();
    lend = debts
        .map((e) => {
              "id": e.debtId,
              "name": e.debtName,
              "date": DateTime.fromMillisecondsSinceEpoch(e.due.seconds * 1000),
              "amount": e.debtTotal.toString(),
              "image": 'images/profile/dazai.jpg',
              "debtor": e.borrowersUserId.length
            })
        .toList();
    print(lend);
    return lend;
  } catch (err) {
    rethrow;
  }
}
