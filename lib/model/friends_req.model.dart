import 'package:cloud_firestore/cloud_firestore.dart';

class FriendsReqs {
  final String username;
  final String anotherUsername;
  final String status;
  final String id;

  const FriendsReqs(
      {required this.username,
      this.id = "",
      required this.anotherUsername,
      required this.status});

  factory FriendsReqs.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return FriendsReqs(
        id: doc.id,
        username: data['username'],
        anotherUsername: data['anotherUsername'],
        status: data['status']);
  }
}

enum Status { requested, accepted, rejected }
