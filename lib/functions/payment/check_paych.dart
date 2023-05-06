import 'get_debt.dart';

class PayRes {
  final int check;
  PromptPay promptPay;
  Bank bank;

  PayRes({required this.check, required this.promptPay, required this.bank});
}

class PromptPay {
  final String promptPayId;
  PromptPay({required this.promptPayId});
}

class Bank {
  final String bankName;
  final String bankId;
  Bank({required this.bankName, required this.bankId});
}

Future<PayRes> checkPaych(String debtId) async {
  try {
    print("เข้าไหม");
    print(debtId);
    int returncheck = 0;
    int prom = 0;
    int bank = 0;
    List<bool> check = [false, false];
    DebtData debtData = await getDebt(debtId);
    print(debtData.toString());
    print(debtData.paych[0].channel);
    for (int i = 0; i < debtData.paych.length; i++) {
      print(debtData.paych[i].channel);
      if ("PromptPay" == debtData.paych[i].channel) {
        check[0] = true;
        prom = i;
      } else {
        check[1] = true;
        bank = i;
      }
    }
    if (check[0] == true) {
      returncheck += 1;
    }
    if (check[1] == true) {
      returncheck += 2;
    }
    print(PayRes(
            check: returncheck,
            promptPay: PromptPay(promptPayId: debtData.paych[prom].number),
            bank: Bank(
                bankName: debtData.paych[bank].channel,
                bankId: debtData.paych[bank].number))
        .toString());
    return PayRes(
        check: returncheck,
        promptPay: PromptPay(promptPayId: debtData.paych[prom].number),
        bank: Bank(
            bankName: debtData.paych[bank].channel,
            bankId: debtData.paych[bank].number));
  } catch (err) {
    rethrow;
  }
}
