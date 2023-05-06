import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/payment/get_blockarray.dart';

import '../../functions/utils/find_borrower_debt_user_by_id.dart';

// final valueAmount = StateProvider<TextEditingController>((ref) => TextEditingController());

class Paymentform extends StatefulWidget {
  const Paymentform(
      {super.key,
      required this.formKey,
      required this.amount,
      required this.detpId});
  final String detpId;
  final GlobalKey formKey;
  final TextEditingController amount;

  @override
  State<Paymentform> createState() => _PaymentformState();
}

class _PaymentformState extends State<Paymentform> {
  List<double> payamount = [];
  // final amount = TextEditingController();

  @override
  void initState() {
    findborrwerBytwoId(widget.detpId).then((value) => print(value));
    // getblockarray(widget.detpId)
    //     .then((value) => setState(() {
    //           payamount = value;
    //         }))
    //     .onError((error, stackTrace) => {print("WTF")});

    super.initState();
  }

  @override
  void dispose() {
    widget.amount.dispose();
    super.dispose();
  }

  setamount(double num) {
    widget.amount.text = num.toString();
  }

  @override
  Widget build(BuildContext context) {
    // var amount = {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            // child: TextFormField(),
            child: TextFormField(
                textAlign: TextAlign.center,
                controller: widget.amount,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                          .hasMatch(value)) {
                    return "Please enter amount";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amounts',
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
