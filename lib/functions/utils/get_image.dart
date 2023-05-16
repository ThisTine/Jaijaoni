import 'package:firebase_storage/firebase_storage.dart';

Future<String> getPicture(String namepic, String type) async {
  try {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final mountainsRef = storageRef.child("$type/$namepic");

    if (namepic != '') {
      var url = await mountainsRef.getDownloadURL();
      return url;
    } else {
      return '';
    }
  } catch (err) {
    print(err);
    rethrow;
  }
}
