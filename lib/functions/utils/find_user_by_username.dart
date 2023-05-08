import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Users>> findUserByUsername(List<String> usernames) async {
  try {
    QuerySnapshot<Map<String, dynamic>> usersDoc = await FireStoreService
        .collection.users
        .where("username", whereIn: usernames)
        .get();
    List<Users> users =
        usersDoc.docs.map((e) => Users.fromFireStore(e)).toList();
    return users;
  } catch (err) {
    rethrow;
  }
}
