import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

final subscriptUserProvider = StreamProvider<Users>((ref) async* {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  late final query = FireStoreService.collection.users.doc(userId);
  late final snapshots = query.snapshots();

  await for (var snapshot in snapshots) {
    Users usr = Users.fromFireStore(snapshot);
    yield usr;
  }

});