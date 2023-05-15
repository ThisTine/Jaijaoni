import 'package:jaijaoni/functions/utils/find_borrower_by_user_id.dart';
import 'package:jaijaoni/model/debt.model.dart';

Future<List<Map<String, dynamic>>> getBow() async {
  try {
    List<Map<String, dynamic>> bow;
    List<Debts> bows = await findBorrowerByUserId();
    bow = bows
        .map((e) => {
              "id": e.debtId,
              "name": e.debtName,
              "date": DateTime.fromMillisecondsSinceEpoch(e.due.seconds * 1000),
              "amount": e.debtTotal.toString(),
              "image": 'images/profile/dazai.jpg',
              "profileId": e.userId,
              "debtor": e.borrowersUserId.length,
              "create": DateTime.fromMillisecondsSinceEpoch(
                  e.createTime.seconds * 1000),
            })
        .toList();
    // print(bow);
    return bow;
  } catch (err) {
    // print(err);
    rethrow;
  }
}
