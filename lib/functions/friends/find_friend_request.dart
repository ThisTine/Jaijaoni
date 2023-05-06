import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/model/user.model.dart';

import '../../services/store/fire_store_service.dart';

Future<FriendsReqs?> findFriendRequest(String username) async{
  try{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Users usr = await findUserById(userId);
    var reqDoc = await FireStoreService.collection.friendsReqs.where("username",isEqualTo: username).where("anotherUsername", isEqualTo: usr.username).get();
    if(reqDoc.docs.isNotEmpty){
      return FriendsReqs.fromFireStore(reqDoc.docs.first);
    }
    var reqDoc2 = await FireStoreService.collection.friendsReqs.where("anotherUsername",isEqualTo: username).where("username", isEqualTo: usr.username).get();
    if(reqDoc2.docs.isNotEmpty){
      return FriendsReqs.fromFireStore(reqDoc2.docs.first);
    }
    return null;

  }catch(err){
    rethrow;
  }
}