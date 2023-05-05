import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/create/add_payment.dart';
import 'package:jaijaoni/functions/create/payment_formatter.dart';

import '../../providers/create/create_debt_data_provider.dart';

class PaymentBottomsheet extends StatefulWidget {
  const PaymentBottomsheet(
      {super.key,
      required this.handlePaymentMethod,
      required this.paymentList});
  final Function(List<PaymentOption>) handlePaymentMethod;
  final List<PaymentOption> paymentList;

  @override
  State<PaymentBottomsheet> createState() => _PaymentBottomsheetState();
}

class _PaymentBottomsheetState extends State<PaymentBottomsheet> {
  final _paymentFormKey = GlobalKey<FormState>();
  final _paymentNumber = TextEditingController();
  final items = ["KBank", "SCB", "PromptPay"];
  String selectedValue = "PromptPay";
  late final List<PaymentOption> newPayment;
  late final PaymentOption newValue;

  String buildFormatString(String text, int index, String replaceTxt) {
    String st = "";
    st = text.substring(0, index);
    st += replaceTxt;
    st += text.substring(index);
    return st;
  }

  void formatPaymentNumber() {
    String text = _paymentNumber.text;
    int length = text.length;
    List<int> formatSet = [3, 5, 11];
    for (int i = 0; i < length; i++) {
      if (formatSet.contains(i) && text[i] != "-") {
        text = buildFormatString(text, i, "-");
      }
    }
    _paymentNumber.text = text;
  }

  @override
  void initState() {
    super.initState();
    newPayment = widget.paymentList;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _paymentFormKey,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MediaQuery.of(context).viewInsets.bottom != 0
                ? MainAxisSize.max
                : MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      'Payment Option',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .fontSize),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton<String>(
                          iconEnabledColor:
                              Theme.of(context).colorScheme.primary,
                          value: selectedValue,
                          items: items
                              .map<DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                      value: value, child: Text(value)))
                              .toList(),
                          onChanged: (newValue) {
                            if (newValue == "PromptPay" ||
                                selectedValue == "PromptPay") {
                              _paymentNumber.text = "";
                            }
                            setState(() {
                              selectedValue = newValue!;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _paymentNumber,
                inputFormatters: selectedValue != "PromptPay"
                    ? [
                        PaymentFormatter(
                            sample: 'xxx-x-xxxxx-x', separator: '-')
                      ]
                    : [],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Payment Number should not be empty';
                  }
                  if (selectedValue != "PromptPay" && value.length != 13) {
                    return 'Please type correct format';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Payment Number',
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () {
                            if (_paymentFormKey.currentState!.validate()) {
                              setState(() {
                                newValue = PaymentOption(channel: selectedValue, number: _paymentNumber.text,isCheck: true);
                                // newValue = {
                                //   "method": selectedValue,
                                //   "number": _paymentNumber.text
                                // };
                              });
                              addPayment(newValue).then((value){
                              widget.handlePaymentMethod(
                                  [...newPayment, newValue]);
                              Navigator.pop(context);
                              }).onError((error, stackTrace) {print(stackTrace);});

                            }
                          },
                          child: Text(
                            'Add Payment',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
