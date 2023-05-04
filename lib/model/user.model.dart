import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String userId;
  final String profilePic;
  final String username;
  final String name;
  final String? quote;
  final List<String> friendList;
  final List<Account> accs;

  const Users(
      {required this.userId,
      required this.profilePic,
      required this.username,
      required this.name,
      this.quote,
      required this.friendList,
      required this.accs});

  factory Users.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Users(
        userId: doc.id,
        profilePic: data['profilePic'],
        username: data['username'],
        name: data['name'],
        quote: data['quote'],
        friendList: (data['friendList'] as List<dynamic>).map((e) => e.toString()).toList(),
        accs: (data['accs'] as List<Map<String, dynamic>>).map((e) => Account(accName: e['accName'], accNo: e['accNo'])).toList());
  }
}

class Account {
  final String accName;
  final String accNo;

  const Account({required this.accName, required this.accNo});

  factory Account.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Account(accName: data['accName'], accNo: data['accNo']);
  }
}
