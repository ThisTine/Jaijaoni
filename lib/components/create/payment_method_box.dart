import 'package:flutter/material.dart';

class PaymentMethodBox extends StatefulWidget {
  const PaymentMethodBox(
      {super.key,
      required this.method,
      required this.number,
      required this.isCheck,
      required this.switchIsCheck});
  final String method;
  final String number;
  final bool isCheck;
  final Function switchIsCheck;

  @override
  State<PaymentMethodBox> createState() => _PaymentMethodBoxState();
}

class _PaymentMethodBoxState extends State<PaymentMethodBox> {
  @override
  Widget build(BuildContext context) {
    // late bool isCheck = widget.isCheck;
    // print(widget.isCheck);

    return Container(
      margin: const EdgeInsets.all(10),
      // width: 358,
      height: 82,
      child: Material(
        elevation: 1,
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onTap: () {
            widget.switchIsCheck();
          },
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
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.fontSize),
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
                        value: widget.isCheck,
                        onChanged: (bool? check) {
                          widget.switchIsCheck();
                        }),
                    // const SizedBox(width: 10)
                  ],
                ),
              )
            ],
          ),
        ),
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
