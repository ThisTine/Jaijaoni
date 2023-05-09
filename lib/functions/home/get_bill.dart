import 'package:jaijaoni/functions/utils/get_image.dart';

Future<String> getBill(String tranImage) async {
  try {
    var urlImage = getPicture(tranImage, 'bill');
    return urlImage;
  } catch (err) {
    rethrow;
  }
}
//NetworkImage(getBill(transactioId))
