import 'package:cloud_firestore/cloud_firestore.dart';

class Borrower {
  final String borrowId;
  final String lenderUsername;
  final String borrowerUsername;
  final double debtTotal;
  final double debtRemaining;
  final Timestamp due;
  final Timestamp borrowedTime;

  const Borrower(
      {required this.borrowId,
      required this.lenderUsername,
      required this.borrowerUsername,
      required this.debtTotal,
      required this.debtRemaining,
      required this.due,
      required this.borrowedTime});

  factory Borrower.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Borrower(
        borrowId: doc.id,
        lenderUsername: data['lenderUsername'],
        borrowerUsername: data['borrowerUsername'],
        debtTotal: data['debtTotal'],
        debtRemaining: data['debtRemaining'],
        due: data['due'],
        borrowedTime: data['borrowedTime']);
  }
}
