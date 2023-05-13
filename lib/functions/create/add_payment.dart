import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<void> addPayment(PaymentOption paymentOption) async {
  try {
    Users user = await findUserById(FirebaseAuth.instance.currentUser!.uid);
    var updatedpaymentOption = user.accs
        .where((element) => !(element.accName == paymentOption.channel &&
            element.accNo == paymentOption.number))
        .toList();
    updatedpaymentOption.add(
        Accounts(accName: paymentOption.channel, accNo: paymentOption.number));
    List<Map<String, String>> paymentOptionMap = updatedpaymentOption
        .map((e) => {"accName": e.accName, "accNo": e.accNo})
        .toList();
    await FireStoreService.collection.users
        .doc(user.userId)
        .update({"accs": paymentOptionMap});
  } catch (err) {
    rethrow;
  }
}
