//Muaymi
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/create/add_box_button.dart';
import 'package:jaijaoni/components/create/payment_method_box.dart';

import '../components/custom_app_bar.dart';

class EditDebtScreen extends StatefulWidget {
  const EditDebtScreen({super.key});

  @override
  State<EditDebtScreen> createState() => _EditDebtScreenState();
}

class _EditDebtScreenState extends State<EditDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Edit", backButton: true),
      body: const EditPayment(paymentList: [
        {"method": "PromptPay", "number": "0891234567"},
        {"method": "KBank", "number": "8677378909"}
      ]),
    );
  }
}

class EditPayment extends StatefulWidget {
  const EditPayment({super.key, required this.paymentList});
  final List<Map<String, String>> paymentList;

  @override
  State<EditPayment> createState() => _EditPaymentState();
}

class _EditPaymentState extends State<EditPayment> {
  late List<Map<String, String>> paymentList;
  @override
  void initState() {
    super.initState();
    paymentList = widget.paymentList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Text(
                    'How do they pay?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ]),
              addPaymentBox(paymentList, (newPaymentList) {
                setState(() {
                  paymentList = newPaymentList;
                });
              }),
              ...paymentList.map((e) =>
                  PaymentMethodBox(method: e["method"]!, number: e["number"]!)),
              const SizedBox(
                height: 50,
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondaryContainer),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addPaymentBox(
      List<Map<String, String>> paymentList, Function handleUpdatePaymentList) {
    return GestureDetector(
      child: const AddBoxButton(title: 'Add Payment', icon: Icons.add),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return PaymentBottomsheet(
                paymentList: paymentList,
                handlePaymentMethod: handleUpdatePaymentList,
              );
            });
      },
    );
  }
}

class PaymentBottomsheet extends StatefulWidget {
  const PaymentBottomsheet(
      {super.key,
      required this.handlePaymentMethod,
      required this.paymentList});
  final Function handlePaymentMethod;
  final List<Map<String, String>> paymentList;

  @override
  State<PaymentBottomsheet> createState() => _PaymentBottomsheetState();
}

class _PaymentBottomsheetState extends State<PaymentBottomsheet> {
  final _paymentFormKey = GlobalKey<FormState>();
  final _paymentNumber = TextEditingController();
  final items = ["KBank", "SCB", "PromptPay"];
  String selectedValue = "PromptPay";
  late final List<Map<String, String>> newPayment;
  late final Map<String, String> newValue;

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
                            setState(() {
                              selectedValue = newValue!;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _paymentNumber,
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
                            setState(() {
                              newValue = {
                                "method": selectedValue,
                                "number": _paymentNumber.text
                              };
                            });
                            widget
                                .handlePaymentMethod([...newPayment, newValue]);
                            Navigator.pop(context);
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
