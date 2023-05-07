import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> removePaymentChannelFromUser(PaymentOption paymentOption) async{
  try{
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Users usr = await findUserById(userId);
    List<Map<String,String>> accs = usr.accs.where((element) => !(element.accName == paymentOption.channel && element.accNo == paymentOption.number)).map((e) => {"accName":e.accName,"accNo":e.accNo}).toList();
    await FireStoreService.collection.users.doc(userId).update({"accs":accs});
  }catch(err){
    rethrow;
  }
}