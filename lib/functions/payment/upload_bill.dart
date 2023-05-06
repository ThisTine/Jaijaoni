import 'get_debt.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadBill(File file, String namepic) async {
  try {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child("bill/$namepic");
    await mountainsRef.putFile(file);
    return '';
  } catch (err) {
    rethrow;
  }
}
