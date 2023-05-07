import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<Debts> getDebtById(String id) async{
  try{
    var doc = await FireStoreService.collection.debts.doc(id).get();
    var debt = Debts.fromFireStore(doc);
    return debt;
  }catch(err){
    rethrow;
  }
}