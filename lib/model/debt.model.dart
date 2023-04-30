import 'package:cloud_firestore/cloud_firestore.dart';

class Debts {
  final String debtId;
  final String userId;
  final String username;
  final String debtName;
  final Timestamp createTime;
  final List<Transactions> transactions;

  const Debts(
      {required this.debtId,
      required this.userId,
      required this.username,
      required this.debtName,
      required this.createTime,
      required this.transactions});

  factory Debts.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Debts(
        debtId: doc.id,
        userId: data['userId'],
        username: data['username'],
        debtName: data['debtname'],
        createTime: data['createTime'],
        transactions: data['transactions'] ?? []);
  }
}

class Transactions {
  final String borrowId;
  final String username;
  final String profilePic;
  final double amount;
  final IsApproved isApproved;
  final String errMessage;

  const Transactions(
      {required this.borrowId,
      required this.username,
      required this.profilePic,
      required this.amount,
      required this.isApproved,
      required this.errMessage});

  factory Transactions.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Transactions(
        borrowId: data['borrowId'],
        username: data['username'],
        profilePic: data['profilePic'],
        amount: data['amount'],
        isApproved: data['isApproved'],
        errMessage: data['errMessage'] ?? '');
  }
}

enum IsApproved { success, error, pending }
