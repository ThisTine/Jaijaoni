import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String userId;
  final String profilePic;
  final String username;
  final String name;
  final String? quote;
  final List<Charts> charts;
  final List<String> friendList;
  final List<Accounts> accs;

  const Users(
      {required this.userId,
      required this.profilePic,
      required this.username,
      required this.name,
      this.quote,
      required this.charts,
      required this.friendList,
      required this.accs});

  factory Users.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Users(
        userId: doc.id,
        profilePic: data['profilePic'] ?? '',
        username: data['username'],
        name: data['name'] ?? '',
        quote: data['quote'] ?? '',
        charts: List<Map<String, dynamic>>.from(data['charts'] ?? [])
            .map((e) => Charts(
                monthLabel: e['monthLabel'],
                lendTotal: e['lendTotal'],
                borrowTotal: e['borrowTotal']))
            .toList(),
        friendList: List<dynamic>.from(data['friendList'] ?? [])
            .map((e) => e.toString())
            .toList(),
        accs: List<Map<String, dynamic>>.from(data['accs'] ?? [])
            .map((e) => Accounts(accName: e['accName'], accNo: e['accNo']))
            .toList());
  }
}

class Accounts {
  final String accName;
  final String accNo;

  const Accounts({required this.accName, required this.accNo});

  factory Accounts.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Accounts(accName: data['accName'], accNo: data['accNo']);
  }
}

class Charts {
  final String monthLabel;
  final double lendTotal;
  final double borrowTotal;

  const Charts(
      {required this.monthLabel,
      required this.lendTotal,
      required this.borrowTotal});

  factory Charts.fromFireStore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Charts(
        monthLabel: data['monthLabel'],
        lendTotal: data['lendTotal'],
        borrowTotal: data['borrowTotal']);
  }
}
