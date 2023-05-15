import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<void> uploadPicture(XFile file, String namepic, String type) async {
  try {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref();
    final mountainsRef = storageRef.child("$type/$namepic");
    // print(mountainsRef);
    final Uint8List fileData = await file.readAsBytes();
    // final files = File(file.path);
    // print("ตรงนี้นะ");
    // print(file.readAsBytes());
    // if (kIsWeb) {
    //   // await mountainsRef.putFile(files);
    //   // await mountainsRef.putFile(file);
    //   // await mountainsRef.putData(
    //   //   file.readAsBytes() as Uint8List,
    //   //   SettableMetadata(contentType: 'image/jpeg'),
    //   // );
    // } else {
    //   // await mountainsRef.putFile(
    //   //     file,
    //   //     SettableMetadata(
    //   //       contentType: "image/*",
    //   //     ));
    // }
    // await mountainsRef.putData(fileData);
    await mountainsRef.putData(
        fileData, SettableMetadata(contentType: file.mimeType));
  } catch (err) {
    rethrow;
  }
}
