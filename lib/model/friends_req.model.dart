import 'package:cloud_firestore/cloud_firestore.dart';

class Friends_Req {
  final String userId;
  final String anotherUserId;
  final Status status;

  const Friends_Req(
      {required this.userId,
      required this.anotherUserId,
      required this.status});

  factory Friends_Req.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Friends_Req(
        userId: data['userId'],
        anotherUserId: data['anotherUserId'],
        status: data['status']);
  }
}

enum Status { requested, friend }
