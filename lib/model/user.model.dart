import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String profilePic;
  final String username;
  final String name;
  final String? quote;
  final Array friendList;
  final Account acc;

  const User(
      {required this.userId,
      required this.profilePic,
      required this.username,
      required this.name,
      this.quote,
      required this.friendList,
      required this.acc});

  factory User.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return User(
        userId: doc.id,
        profilePic: data['profilePic'],
        username: data['username'],
        name: data['name'],
        friendList: data['friendList'] ?? '',
        acc: data['acc'] ?? '');
  }
}

class Account {
  final String accName;
  final String accNo;

  const Account({required this.accName, required this.accNo});

  factory Account.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data as Map;
    return Account(accName: data['accName'], accNo: data['accNo']);
  }
}
