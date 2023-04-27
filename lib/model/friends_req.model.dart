import 'package:cloud_firestore/cloud_firestore.dart';

class Friends_Req {
  final String username;
  final String anotherUsername;
  final Status status;

  const Friends_Req(
      {required this.username,
      required this.anotherUsername,
      required this.status});

  factory Friends_Req.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Friends_Req(
        username: data['username'],
        anotherUsername: data['anotherUsername'],
        status: data['status']);
  }
}

enum Status { requested, friend }
