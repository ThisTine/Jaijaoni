import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsReqs {
  final String username;
  final String anotherUsername;
  final Status status;

  const FriendsReqs(
      {required this.username,
      required this.anotherUsername,
      required this.status});

  factory FriendsReqs.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return FriendsReqs(
        username: data['username'],
        anotherUsername: data['anotherUsername'],
        status: data['status']);
  }
}

enum Status { requested, accepted, rejected }
