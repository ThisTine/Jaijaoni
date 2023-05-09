import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/model/friends_req.model.dart';

Future<bool> profileFriend(String userFriend) async {
  try {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FriendsReqs? userf = await findFriendRequest(userId);

    return !(userf == null || userf.status != 'accepted');
  } catch (err) {
    rethrow;
  }
}
