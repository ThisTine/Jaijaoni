import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/friends_req.model.dart';

import '../../services/store/fire_store_service.dart';

Future<FriendsReqs?> findFriendRequest(String username) async{
  try{
    String userId = FirebaseAuth.instance.currentUser!.uid;

    var reqDoc = await FireStoreService.collection.friendsReqs.where("username",isEqualTo: username).where("anotherUsername", isEqualTo: userId).get();
    if(reqDoc.docs.isEmpty){
    reqDoc = await FireStoreService.collection.friendsReqs.where("anotherUsername",isEqualTo: username).where("username", isEqualTo: userId).get();
    }
    if(reqDoc.docs.isEmpty){
      return null;
    }
      return FriendsReqs.fromFireStore(reqDoc.docs.first);

  }catch(err){
    rethrow;
  }
}