import 'package:cloud_firestore/cloud_firestore.dart';

class Borrowers {
  final String borrowId;
  final String debtId;
  final String lenderUserId;
  final String lenderUsername;
  final String borrowerUserId;
  final String borrowerUsername;
  final double debtTotal;
  final double debtRemaining;
  final DateTime due;
  final Timestamp borrowedTime;

  const Borrowers(
      {required this.borrowId,
      required this.debtId,
      required this.lenderUserId,
      required this.lenderUsername,
      required this.borrowerUserId,
      required this.borrowerUsername,
      required this.debtTotal,
      required this.debtRemaining,
      required this.due,
      required this.borrowedTime});

  factory Borrowers.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Borrowers(
        borrowId: doc.id,
        debtId: data['debtId'],
        lenderUserId: data['lenderUserId'],
        lenderUsername: data['lenderUsername'],
        borrowerUserId: data['borrowerUserId'],
        borrowerUsername: data['borrowerUsername'],
        debtTotal: data['debtTotal'],
        debtRemaining: data['debtRemaining'],
        due: data['due'],
        borrowedTime: data['borrowedTime']);
  }
}
