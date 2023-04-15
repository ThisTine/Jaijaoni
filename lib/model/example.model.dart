import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String? quote;

  const User({required this.id, required this.name, this.quote});

  factory User.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return User(id: doc.id, name: data['name'] ?? '', quote: data['quote']);
  }
}
