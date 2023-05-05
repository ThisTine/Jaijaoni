import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user.model.dart';
import '../../services/store/fire_store_service.dart';

Future<Users> findUserById(String username) async{
  try{
    DocumentSnapshot<Map<String, dynamic>> usersDoc = await FireStoreService.collection.users.doc(username).get();
    // List<Users> users = usersDoc.docs.map((e) => Users.fromFireStore(e)).toList();
    Users user = Users.fromFireStore(usersDoc);
    return user;
  }catch(err){
    rethrow;
  }
}