import 'package:flutter/material.dart';

class PaymentMethodBox extends StatefulWidget {
  const PaymentMethodBox(
      {super.key, required this.method, required this.number});
  final String method;
  final String number;

  @override
  State<PaymentMethodBox> createState() => _PaymentMethodBoxState();
}

class _PaymentMethodBoxState extends State<PaymentMethodBox> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      // width: 358,
      height: 82,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondaryContainer,
          boxShadow: [
            BoxShadow(
                blurRadius: 4,
                offset: const Offset(1, 1),
                color: Colors.grey.withOpacity(0.5))
          ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                showImage(),
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Text(
                    widget.number,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (bool? check) {
                      setState(() {
                        isChecked = check!;
                      });
                    }),
                // const SizedBox(width: 10)
              ],
            ),
          )
        ],
      ),
    );
  }

  showImage() {
    if (widget.method == "PromptPay") {
      return image("promptpay.png");
    } else if (widget.method == "KBank") {
      return image("kbank.png");
    } else if (widget.method == "SCB") {
      return image("scb.png");
    }
  }

  Widget image(String imageName) {
    return Container(
      width: 49,
      height: 49,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.topCenter,
              image: AssetImage("images/payment/$imageName"))),
    );
  }
}
