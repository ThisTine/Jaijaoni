import 'package:jaijaoni/functions/utils/find_borrows_by_user_id.dart';
import 'package:jaijaoni/model/borrower.model.dart';

class AnalaysisProfile {
  final double paid;
  final double unpaid;
  AnalaysisProfile({required this.paid, required this.unpaid});
}

Future<AnalaysisProfile> analaysisUserProfile() async {
  try {
    var paid = 0.0;
    var unpaid = 0.0;
    List<Borrowers> allborrow = await findBorrowsByUserId();
    for (int i = 0; i < allborrow.length; i++) {
      paid += (allborrow[i].debtTotal - allborrow[i].debtRemaining);
      unpaid += allborrow[i].debtRemaining;
    }
    return AnalaysisProfile(paid: paid, unpaid: unpaid);
  } catch (err) {
    rethrow;
  }
}
