import 'package:jaijaoni/functions/utils/get_image.dart';

Future<String> getProfilePicture(String profilePic) async {
  try {
    var urlImage = getPicture(profilePic, 'profile_pic');
    return urlImage;
  } catch (err) {
    rethrow;
  }
}
