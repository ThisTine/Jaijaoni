import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsReqs {
  final String username;
  final String anotherUsername;
  final Status status;

  const FriendsReqs(
      {required this.username,
      required this.anotherUsername,
      required this.status});

  factory FriendsReqs.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return FriendsReqs(
        username: data['username'],
        anotherUsername: data['anotherUsername'],
        status: data['status']);
  }
}

enum Status { requested, friend }
