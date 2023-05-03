import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String? quote;
  final List<String> friendList;

  const User(
      {required this.id,
      required this.name,
      this.quote,
      this.friendList = const []});

  factory User.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return User(
        id: doc.id,
        name: data['name'] ?? '',
        quote: data['quote'],
        friendList: (data['friendList'] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }
}
