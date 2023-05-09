import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/model/friends_req.model.dart';

Future<bool> findFriendProfile(String userFriend) async {
  try {
    FriendsReqs? userf = await findFriendRequest(userFriend);
    return !(userf == null || userf.status != 'accepted');
  } catch (err) {
    rethrow;
  }
}
