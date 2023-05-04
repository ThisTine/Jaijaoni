import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaijaoni/model/example.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<User> getFriends(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FireStoreService.collection.users.doc(userId).get();
    return User.fromFireStore(user);
  } catch (err) {
    rethrow;
  }
}
