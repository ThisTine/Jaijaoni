import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

class CircularChart {
  final double lenderPaidDebt;
  final double lenderTotalDebt;
  final double borrowerPaidDebt;
  final double borrowerTotalDebt;
  final int lenderAmount;
  final int borrowerAmount;
  CircularChart(
      {required this.lenderPaidDebt,
      required this.lenderTotalDebt,
      required this.lenderAmount,
      required this.borrowerAmount,
      required this.borrowerPaidDebt,
      required this.borrowerTotalDebt});
}

Future<CircularChart> getChart() async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DateTime dateNow = DateTime.now();
    DateTime startOfMonth = DateTime(dateNow.year, dateNow.month, 1);
    DateTime endOfMonth = DateTime(dateNow.year, dateNow.month + 1, 0);
    var leanderDocQuery = await FireStoreService.collection.borrowers
        .where("borrowedTime", isLessThanOrEqualTo: endOfMonth)
        .where("borrowedTime", isGreaterThanOrEqualTo: startOfMonth)
        .where("lenderUserId", isEqualTo: userId)
        .get();
    var borrowerDocQuery = await FireStoreService.collection.borrowers
        .where("borrowedTime", isLessThanOrEqualTo: endOfMonth)
        .where("borrowedTime", isGreaterThanOrEqualTo: startOfMonth)
        .where("borrowerUserId", isEqualTo: userId)
        .get();
    List<Borrowers> lenderBorrowers =
        leanderDocQuery.docs.map((e) => Borrowers.fromFireStore(e)).toList();
    List<Borrowers> borrowerBorrowers =
        borrowerDocQuery.docs.map((e) => Borrowers.fromFireStore(e)).toList();

    return CircularChart(
        lenderAmount:
            lenderBorrowers.map((e) => e.borrowerUserId).toSet().length,
        borrowerAmount:
            borrowerBorrowers.map((e) => e.lenderUserId).toSet().length,
        lenderPaidDebt: lenderBorrowers.isEmpty
            ? 0.toDouble()
            : lenderBorrowers
                .map((e) => e.debtTotal - e.debtRemaining)
                .reduce((value, element) => value + element)
                .toDouble(),
        lenderTotalDebt: lenderBorrowers.isEmpty
            ? 0.toDouble()
            : lenderBorrowers
                .map((e) => e.debtTotal)
                .reduce((value, element) => value + element)
                .toDouble(),
        borrowerPaidDebt: borrowerBorrowers.isEmpty
            ? 0.toDouble()
            : borrowerBorrowers
                .map((e) => e.debtTotal - e.debtRemaining)
                .reduce((value, element) => value + element)
                .toDouble(),
        borrowerTotalDebt: borrowerBorrowers.isEmpty
            ? 0.toDouble()
            : borrowerBorrowers
                .map((e) => e.debtTotal)
                .reduce((value, element) => value + element)
                .toDouble());
  } catch (err) {
    rethrow;
  }
}
