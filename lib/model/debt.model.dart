import 'package:cloud_firestore/cloud_firestore.dart';

class Debts {
  final String debtId;
  final String userId;
  final String username;
  final List<String> borrowersUserId;
  final String debtName;
  final double debtTotal;
  final Timestamp createTime;
  final Timestamp due;
  final List<PayChannels> payChannels;
  final List<Transactions> transactions;

  const Debts(
      {required this.debtId,
      required this.userId,
      required this.username,
      required this.borrowersUserId,
      required this.debtName,
      required this.debtTotal,
      required this.createTime,
      required this.due,
      required this.payChannels,
      required this.transactions});

  factory Debts.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Debts(
        debtId: doc.id,
        userId: data['userId'],
        username: data['username'],
        borrowersUserId: List<dynamic>.from(data['borrowersUserId'] ?? [])
            .map((e) => e.toString())
            .toList(),
        debtName: data['debtName'],
        debtTotal: data['debtTotal'],
        createTime: data['createTime'],
        due: data['due'],
        payChannels: List<Map<String, dynamic>>.from(data['payChannels'] ?? [])
            .map((e) => PayChannels(channel: e['channel'], number: e['number']))
            .toList(),
        transactions:
            List<Map<String, dynamic>>.from(data['transactions'] ?? [])
                .map((e) => Transactions(
                    transactionId: e['transactionId'],
                    borrowId: e['borrowId'],
                    username: e['username'],
                    profilePic: e['profilePic'],
                    amount: e['amount'],
                    isApproved: e['isApproved'],
                    errMessage: e['errMessage']))
                .toList());
  }
}

class Transactions {
  final String transactionId;
  final String borrowId;
  final String username;
  final String profilePic;
  final double amount;
  final IsApproved isApproved;
  final String errMessage;

  const Transactions(
      {required this.transactionId,
      required this.borrowId,
      required this.username,
      required this.profilePic,
      required this.amount,
      required this.isApproved,
      required this.errMessage});

  factory Transactions.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Transactions(
        transactionId: doc.id,
        borrowId: data['borrowId'],
        username: data['username'],
        profilePic: data['profilePic'],
        amount: data['amount'],
        isApproved: data['isApproved'],
        errMessage: data['errMessage'] ?? '');
  }
}

enum IsApproved { success, error, pending }

class PayChannels {
  final String channel;
  final String number;

  const PayChannels({required this.channel, required this.number});

  factory PayChannels.fromFireStore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return PayChannels(channel: data['channel'], number: data['number']);
  }
}
