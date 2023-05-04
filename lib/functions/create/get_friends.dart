import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<Users> getFriends(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FireStoreService.collection.users.doc(userId).get();
    print(user.data());
    return Users.fromFireStore(user);
  } catch (err) {
    rethrow;
  }
}
