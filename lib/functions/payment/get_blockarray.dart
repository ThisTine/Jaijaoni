import 'get_borrower.dart';

final List<double> one = [1, 3, 5];
final List<double> two = [100, 1000, 10000];

Future<List<double>> getblockarray(String debtId) async {
  try {
    final List<double> payamount = [];
    BorrowerData borrower = await getBorrower(debtId);
    final amount = borrower.total;
    if (amount > 25) {
      payamount.add(25);
      if (amount > 50) {
        for (int i = 0; i < two.length; i++) {
          for (int j = 0; j < one.length; j++) {
            double a = two[i] * one[j];
            if (a < amount) {
              payamount.add(a);
            } else {
              break;
            }
          }
        }
      }
    }
    payamount.add(amount);
    return payamount;
  } catch (err) {
    rethrow;
  }
}
