import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

Future<List<PaymentOption>> getPaymentOption() async {
  try{
  Users user = await findUserById(FirebaseAuth.instance.currentUser!.uid);
  return user.accs.map((e) => PaymentOption(channel: e.accName, number: e.accNo)).toList();
  }catch(err){
    rethrow;
  }

}