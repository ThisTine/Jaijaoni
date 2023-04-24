import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {
  final String debtId;
  final String userId;
  final String username;
  final String debtName;
  final Timestamp createTime;

  const Debt(
      {required this.debtId,
      required this.userId,
      required this.username,
      required this.debtName,
      required this.createTime});

  factory Debt.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Debt(
        debtId: doc.id,
        userId: data['userId'],
        username: data['username'],
        debtName: data['debtname'],
        createTime: data['createTime']);
  }
}
