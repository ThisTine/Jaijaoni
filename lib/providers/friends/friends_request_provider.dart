import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/functions/utils/find_user_by_username.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/model/user.model.dart';

import '../../services/store/fire_store_service.dart';

final friendsRequestProvider = StreamProvider<List<Users>>((ref) async* {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final String username = (await findUserById(userId)).username;
  final Query<Map<String, dynamic>> query = FireStoreService
      .collection.friendsReqs
      .where("anotherUsername", isEqualTo: username)
      .where("status", isEqualTo: "requested");
  final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
      query.snapshots();

  await for (var snapshot in snapshots) {
    if (snapshot.docs.isEmpty) {
      yield [];
    }
    List<FriendsReqs> freq =
        snapshot.docs.map((e) => FriendsReqs.fromFireStore(e)).toList();
    if (freq.isNotEmpty) {
      List<Users> friends =
          await findUserByUsername(freq.map((e) => e.username).toList());
      yield friends;
    } else {
      yield [];
    }
  }
  yield [];
});
