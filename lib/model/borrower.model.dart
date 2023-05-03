import 'package:cloud_firestore/cloud_firestore.dart';

class Borrowers {
  final String borrowId;
  final String debtId;
  final String lenderUsername;
  final String borrowerUsername;
  final double debtTotal;
  final double debtRemaining;
  final DateTime due;
  final Timestamp borrowedTime;

  const Borrowers(
      {required this.borrowId,
      required this.debtId,
      required this.lenderUsername,
      required this.borrowerUsername,
      required this.debtTotal,
      required this.debtRemaining,
      required this.due,
      required this.borrowedTime});

  factory Borrowers.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Borrowers(
        borrowId: doc.id,
        debtId: data['debtId'],
        lenderUsername: data['lenderUsername'],
        borrowerUsername: data['borrowerUsername'],
        debtTotal: data['debtTotal'],
        debtRemaining: data['debtRemaining'],
        due: data['due'],
        borrowedTime: data['borrowedTime']);
  }
}
