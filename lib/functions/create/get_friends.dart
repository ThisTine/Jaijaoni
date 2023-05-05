import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaijaoni/functions/utils/find_user_by_username.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

class FriendData{
  final String id;
  final String username;
  final String name;
  FriendData({required this.id,required this.username,required this.name});
}

Future<List<FriendData>> getFriends(String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> user =
        await FireStoreService.collection.users.doc(userId).get();
    Users userData = Users.fromFireStore(user);
    List<String> usernames = userData.friendList;
    List<Users> friends = await findUserByUsername(usernames);
    return friends.map((e) => FriendData(id: e.userId, username: e.username, name: e.name)).toList();
  } catch (err) {
    rethrow;
  }
}
