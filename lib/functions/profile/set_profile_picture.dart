import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaijaoni/functions/payment/create_transction.dart';
import 'package:jaijaoni/functions/payment/get_borrower.dart';
import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/functions/payment/upload_bill.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:uuid/uuid.dart';

import '../../services/store/fire_store_service.dart';

Future<void> setProfilepicture(XFile file) async {
  try {
    var uuid = const Uuid();
    var id = uuid.v4();
    String username = FirebaseAuth.instance.currentUser!.uid;
    Users user = await findUserById(username);
    var qurey = await FireStoreService.collection.users.doc(username);
    await qurey.update({"profilePic": id});
    uploadPicture(file, id, 'profile_pic');
  } catch (err) {
    rethrow;
  }
}
