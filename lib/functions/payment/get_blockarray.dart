import 'get_borrower.dart';

final List<double> one = [1, 3, 5, 10];
final List<double> two = [100, 1000];

Future<List<double>> getblockarray(String debtId) async {
  try {
    final List<double> payamount = [25, 50];
    BorrowerData borrower = await getBorrower(debtId);
    // double a;
    final amount = borrower.total;
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
    payamount.add(amount);
    print("asdasdasdasd");
    print(payamount);
    return payamount;
  } catch (err) {
    print("catch1");
    rethrow;
  }
}
