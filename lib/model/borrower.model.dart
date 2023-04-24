import 'package:cloud_firestore/cloud_firestore.dart';

class Borrower {
  final String borrowId;
  final String lenderUserId;
  final String borrowerUserId;
  final int debtTotal;
  final int debtRemaining;
  final Timestamp due;
  final Timestamp borrowedTime;

  const Borrower(
      {required this.borrowId,
      required this.lenderUserId,
      required this.borrowerUserId,
      required this.debtTotal,
      required this.debtRemaining,
      required this.due,
      required this.borrowedTime});

  factory Borrower.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Borrower(
        borrowId: doc.id,
        lenderUserId: data['lenderUserId'],
        borrowerUserId: data['borrowerUserId'],
        debtTotal: data['debtTotal'],
        debtRemaining: data['debtRemaining'],
        due: data['due'],
        borrowedTime: data['borrowedTime']);
  }
}
