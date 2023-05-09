import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

class DebtPeopleItemObject {
  final String name;
  final String id;
  final double total;
  final bool isLent;
  DebtPeopleItemObject(
      {required this.name,
      required this.id,
      required this.total,
      this.isLent = false});
}

const months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

Future<List<DebtPeopleItemObject>> getBorrowersbymonthLabel(
    String monthLabel) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> splittedLabel = monthLabel.split(", ");
    int monthIndex = 0;
    for (int i = 0; i < months.length; i++) {
      if (splittedLabel.first == months[i]) {
        monthIndex = i;
        break;
      }
    }
    DateTime monthlb = DateTime(int.parse(splittedLabel.last), monthIndex);
    var queryborrower = FireStoreService.collection.borrowers
        .where("borrowedTime",
            isLessThanOrEqualTo: DateTime(monthlb.year, monthlb.month + 2, 0))
        .where("borrowedTime",
            isGreaterThanOrEqualTo:
                DateTime(monthlb.year, monthlb.month + 1, 1))
        .where("borrowerUserId", isEqualTo: userId);

    var querylender = FireStoreService.collection.borrowers
        .where("borrowedTime",
            isLessThanOrEqualTo: DateTime(monthlb.year, monthlb.month + 2, 0))
        .where("borrowedTime",
            isGreaterThanOrEqualTo:
                DateTime(monthlb.year, monthlb.month + 1, 1))
        .where("lenderUserId", isEqualTo: userId);
    var docsBorrower = await queryborrower.get();
    var docsLender = await querylender.get();
    // print(docsBorrower.docs.map((e) => e.data()));
    // print(docsLender.docs.map((e) => e.data()));
    List<Borrowers> borrowers =
        docsBorrower.docs.map((e) => Borrowers.fromFireStore(e)).toList();
    List<Borrowers> lenders =
        docsLender.docs.map((e) => Borrowers.fromFireStore(e)).toList();

    // print(lenders.map((e) => {
    //       "t": e.borrowedTime.toDate().toString(),
    //       "amount": e.debtTotal.toString()
    //     }));

    List<DebtPeopleItemObject> db = [];
    for (var borrower in borrowers) {
      if (db
          .where((element) =>
              !element.isLent && borrower.lenderUserId == element.id)
          .isNotEmpty) {
        db = db
            .map((e) => e.id == borrower.lenderUserId && !e.isLent
                ? DebtPeopleItemObject(
                    name: e.name, id: e.id, total: e.total + borrower.debtTotal)
                : e)
            .toList();
      } else {
        db = [
          ...db,
          DebtPeopleItemObject(
              name: borrower.lenderUsername,
              id: borrower.lenderUserId,
              total: borrower.debtTotal)
        ];
      }
    }
    for (var lender in lenders) {
      if (db
          .where((element) =>
              element.isLent && lender.borrowerUserId == element.id)
          .isNotEmpty) {
        db = db
            .map((e) => e.id == lender.borrowerUserId && e.isLent
                ? DebtPeopleItemObject(
                    name: e.name,
                    id: e.id,
                    total: e.total + lender.debtTotal,
                    isLent: e.isLent)
                : e)
            .toList();
      } else {
        db = [
          ...db,
          DebtPeopleItemObject(
              name: lender.borrowerUsername,
              id: lender.borrowerUserId,
              total: lender.debtTotal,
              isLent: true)
        ];
      }
    }
    db.sort((a, b) => b.total.compareTo(a.total));
    return db;
  } catch (err) {
    rethrow;
  }
}
