import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionNames {
  final String users = 'Users';
  final String friendsReqs = 'FriendsReqs';
  final String debts = 'Debts';
  final String borrowers = 'Borrowers';
}

class FireStoreService {
  static final instance = FirebaseFirestore.instance;
  final users = instance.collection("Users");
  final friendsReqs = instance.collection("FriendsReqs");
  final debts = instance.collection("Debts");
  final borrowers = instance.collection("Borrowers");
  static FireStoreService get collection => FireStoreService();
  static CollectionNames get collectionNames => CollectionNames();
}


// EXAMPLE

// final queryusers =
//     FireStoreService.collection.users.get().then((value) => print(value));
