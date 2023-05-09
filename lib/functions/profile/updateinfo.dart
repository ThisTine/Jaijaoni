import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> update(Users usr) async {
  try {
    var query = FireStoreService.collection.users.doc(usr.userId);
    await query.update({"name": usr.name, "quote": usr.quote});
  } catch (err) {
    rethrow;
  }
}
