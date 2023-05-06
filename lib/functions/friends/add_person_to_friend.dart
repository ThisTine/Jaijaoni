import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> addPersonToFriend(String username) async{
  try{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FriendsReqs? req = await findFriendRequest(username);
    if(req != null) throw "Friends Request already exist";
    Map<String,String> friendsReqsMap = {"username": userId,"anotherUsername": username,"status":"requested"};
    await FireStoreService.collection.friendsReqs.add(friendsReqsMap);
  }catch(err){
    rethrow;
  }
}