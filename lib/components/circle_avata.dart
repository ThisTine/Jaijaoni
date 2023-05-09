import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaijaoni/functions/profile/get_profile_picture.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Widget circleAvata({required double radius, required XFile imagefile}) {
  return Center(
    child: CircleAvatar(
      radius: radius,
      backgroundImage: kIsWeb
          ? Image.network(imagefile.path).image
          : Image.file(File(imagefile.path)).image,
    ),
  );
}

// Widget circleAvataDefuq({required double radius}) {
//   return Center(
//     child: CircleAvatar(
//         radius: radius,
//         backgroundImage: const AssetImage('assets/profile.jpg')),
//   );
// }

Widget circleAvataUser({required double radius, required String imgUrl}) {
  // if (imgUrl != '') {
  return Center(
      child: CircleAvatar(
          radius: radius,
          backgroundImage: const AssetImage('assets/profile.jpg'),
          foregroundImage: NetworkImage(imgUrl)));
  // }
  //  else {
  //   return circleAvataDefuq(radius: radius);
  // }
}

Future<String> profilepic() async {
  try {
    String username = FirebaseAuth.instance.currentUser!.uid;
    Users user = await findUserById(username);
    String imgUrl = await getProfilePicture(user.userId);
    return imgUrl;
  } catch (err) {
    return '';
    // rethrow;
  }
}

Future<String> picFrined(uid) async {
  try {
    Users user = await findUserById(uid);
    String imgUrl = await getProfilePicture(user.userId);
    return imgUrl;
  } catch (err) {
    return '';
    // rethrow;
  }
}

Future<String> picFrinedbyusername(username) async {
  try {
    QuerySnapshot<Map<String, dynamic>> userDoc = await FireStoreService
        .collection.users
        .where("username", isEqualTo: username)
        .get();
    Users user = Users.fromFireStore(userDoc.docs.first);
    String imgUrl = await getProfilePicture(user.userId);
    return imgUrl;
  } catch (err) {
    return '';
    // rethrow;
  }
}
