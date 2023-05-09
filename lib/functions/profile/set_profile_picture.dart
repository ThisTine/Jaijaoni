import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaijaoni/functions/payment/upload_bill.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';

Future<void> setProfilepicture(XFile file) async {
  try {
    String username = FirebaseAuth.instance.currentUser!.uid;
    Users user = await findUserById(username);
    uploadPicture(file, user.userId, 'profile_pic');
  } catch (err) {
    rethrow;
  }
}
