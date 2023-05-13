import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> addPersonToFriend(String username) async{
  try{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Users usr = await findUserById(userId);
    FriendsReqs? req = await findFriendRequest(username);
    if(req != null) throw "Friends Request already exist";
    Map<String,String> friendsReqsMap = {"username": usr.username,"anotherUsername": username,"status":"requested"};
    await FireStoreService.collection.friendsReqs.add(friendsReqsMap);
  }catch(err){
    rethrow;
  }
}