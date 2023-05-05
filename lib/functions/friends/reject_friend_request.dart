import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/model/friends_req.model.dart';

import '../../services/store/fire_store_service.dart';

Future<void> rejectFriendRequest(String username) async{
  try{
    FriendsReqs? req = await findFriendRequest(username);
    if(req == null) throw "Friend Request does not exist";
    await FireStoreService.collection.friendsReqs.doc(req.id).delete();
  }catch(err){
    rethrow;
  }
}