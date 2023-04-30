import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsReq {
  final String username;
  final String anotherUsername;
  final Status status;

  const FriendsReq(
      {required this.username,
      required this.anotherUsername,
      required this.status});

  factory FriendsReq.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return FriendsReq(
        username: data['username'],
        anotherUsername: data['anotherUsername'],
        status: data['status']);
  }
}

enum Status { requested, friend }
