import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<Borrowers> getBorrowerByDebtAndUserId(String debtId) async {
  try {
    var query = await FireStoreService()
        .borrowers
        .where("debtId", isEqualTo: debtId)
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser?.uid ?? "")
        .get();
    Borrowers borrower = Borrowers.fromFireStore(query.docs.first);
    return borrower;
  } catch (e) {
    rethrow;
  }
}
