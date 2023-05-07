import 'package:jaijaoni/functions/payment/get_debt.dart';
import 'package:jaijaoni/model/debt.model.dart';

class Lend {
  final String id;
  final String name;
  final String date;
  final double amount;
  final int debtor;
  final String image;
  Lend(
      {required this.id,
      required this.name,
      required this.date,
      required this.amount,
      required this.debtor,
      required this.image});
}

Future<List<Lend>> getLend () async{
  try {
      List<Debts> debts = await
    
  } catch (err) {
   rethrow; 
  }
}
