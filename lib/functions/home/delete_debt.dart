import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> deleteDebtbyId({required String debtId}) async {
  try {
    await FireStoreService.collection.debts.doc(debtId).delete();
  } catch (err) {
    rethrow;
  }
}
