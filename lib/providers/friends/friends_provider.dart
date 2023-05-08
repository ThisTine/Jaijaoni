import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/functions/utils/find_user_by_username.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

final friendsProvider = StreamProvider<List<Users>>((ref) async* {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  late final DocumentReference<Map<String, dynamic>> query =
      FireStoreService.collection.users.doc(userId);
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
      query.snapshots();
  await for (var snapshot in snapshots) {
    if (snapshot.exists) {
      yield [];
    }
    List<String> usr = Users.fromFireStore(snapshot).friendList;
    if (usr.isNotEmpty) {
      List<Users> friends = await findUserByUsername(usr);
      yield friends;
    } else {
      yield [];
    }

    // print("Yielding");
  }
});
