import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_debt_by_id.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/functions/utils/get_image.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/model/user.model.dart';

Future<String> getProfilePicture() async {
  Users user = await findUserById(FirebaseAuth.instance.currentUser!.uid);
  var urlImage = getPicture(user.profilePic, 'profile_pic');
  return urlImage;
}
