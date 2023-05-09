import 'package:jaijaoni/functions/utils/find_debt_by_user_id.dart';
import 'package:jaijaoni/model/debt.model.dart';

Future<List<Map<String, dynamic>>> getLend() async {
  try {
    List<Map<String, dynamic>> lend;
    List<Debts> debts = await findDebtsByUserId();
    lend = debts
        .map((e) => {
              "id": e.debtId,
              "name": e.debtName,
              "date": DateTime.fromMillisecondsSinceEpoch(e.due.seconds * 1000),
              "amount": e.debtTotal.toString(),
              "image": 'images/profile/dazai.jpg',
              "debtor": e.borrowersUserId.length,
              "profileId": e.borrowersUserId.first
            })
        .toList();
    return lend;
  } catch (err) {
    rethrow;
  }
}
