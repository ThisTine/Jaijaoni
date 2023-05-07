import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> editPaymentChannels( List<PaymentOption> options, String debtId ) async{
  try{
    List<Map<String,String>> payChannels = options.map((e) => {"channel":e.channel,"number":e.number}).toList();
    var query = FireStoreService.collection.debts.doc(debtId);
    await query.update({"payChannels":payChannels});
  }catch(err){
    rethrow;
  }
}