// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

final amount = TextEditingController();

class Paymentform extends StatelessWidget {
  const Paymentform({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Payment_form(),
        ]);
  }
}

class Payment_form extends StatefulWidget {
  const Payment_form({super.key});

  get amounts => amount.text;

  @override
  State<Payment_form> createState() => _Payment_formState();
}

class _Payment_formState extends State<Payment_form> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void amountdispose() {
    amount.dispose();
  }

  setamount(int num) {
    amount.text = num.toString();
  }

  @override
  Widget build(BuildContext context) {
    List<int> payamount = [25, 50, 100, 300, 500, 1000];
    // var amount = {};
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            // child: TextFormField(),
            child: TextFormField(
                textAlign: TextAlign.center,
                controller: amount,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                  hintText: '---',
                ),
                keyboardType: TextInputType.number),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(maxWidth: 576),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // alignment: WrapAlignment.spaceBetween,
              children: payamount
                  .map(
                    (e) => Container(
                      // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setamount(e);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        child: Text(
                          e.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        )
      ],
    );
  }
}
