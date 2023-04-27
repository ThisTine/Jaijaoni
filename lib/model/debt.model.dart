import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {
  final String debtId;
  final String userId;
  final String username;
  final String debtName;
  final Timestamp createTime;
  final List<Transaction> transactions;

  const Debt(
      {required this.debtId,
      required this.userId,
      required this.username,
      required this.debtName,
      required this.createTime,
      required this.transactions});

  factory Debt.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Debt(
        debtId: doc.id,
        userId: data['userId'],
        username: data['username'],
        debtName: data['debtname'],
        createTime: data['createTime'],
        transactions: data['transactions'] ?? []);
  }
}

class Transaction {
  final String borrowId;
  final String username;
  final String profilePic;
  final double amount;
  final IsApproved isApproved;
  final String errMessage;

  const Transaction(
      {required this.borrowId,
      required this.username,
      required this.profilePic,
      required this.amount,
      required this.isApproved,
      required this.errMessage});

  factory Transaction.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Transaction(
        borrowId: data['borrowId'],
        username: data['username'],
        profilePic: data['profilePic'],
        amount: data['amount'],
        isApproved: data['isApproved'],
        errMessage: data['errMessage'] ?? '');
  }
}

enum IsApproved { success, error, pending }
