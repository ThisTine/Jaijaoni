import 'package:jaijaoni/functions/utils/find_borrower_debt_friend_by_fid.dart';
import 'package:jaijaoni/model/borrower.model.dart';

import 'analaysis_user_profile.dart';

Future<AnalaysisProfile> analaysisFriendProfile(String friendId) async {
  try {
    var paid = 0.0;
    var unpaid = 0.0;
    List<Borrowers> allborrow = await findBorrowsandLenderById(friendId);
    for (int i = 0; i < allborrow.length; i++) {
      paid += (allborrow[i].debtTotal - allborrow[i].debtRemaining);
      unpaid += allborrow[i].debtRemaining;
    }
    return AnalaysisProfile(paid: paid, unpaid: unpaid);
  } catch (err) {
    rethrow;
  }
}
