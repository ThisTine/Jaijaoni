import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaijaoni/functions/friends/find_friend_request.dart';
import 'package:jaijaoni/functions/utils/find_user_by_username.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/model/user.model.dart';

import '../../services/store/fire_store_service.dart';

Future<void> removeFriend(String username) async{
  try{
    FriendsReqs? req = await findFriendRequest(username);
    if(req == null) throw "Friend Request does not exist";
    List<Users> users = await findUserByUsername([req.username,req.anotherUsername]);
    WriteBatch batch = FireStoreService.instance.batch();
    batch.delete(FireStoreService.collection.friendsReqs.doc(req.id));
    for(Users user in users){
      String addedUserId = user.username == req.username ? req.anotherUsername : req.username;
      List<String> friendList = [...user.friendList.where((element) => element != addedUserId).toList()];
      batch.update(FireStoreService.collection.users.doc(user.userId), {"friendList":friendList});
    }
    await batch.commit();
  }catch(err){
    rethrow;
  }
}