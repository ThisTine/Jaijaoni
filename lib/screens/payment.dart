//Gun
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/payment/payment_form.dart';
import '../components/custom_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarBuilder(context,
            text: "Select amount", backButton: true),
        body: Column(children: [
          Row(
            children: [
              const SizedBox(width: 16.0),
              Flexible(
                child: Text(
                  'How much do you want to pay ?',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize),
                ),
              ),
            ],
          ),
          const Paymentform(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    padding: const EdgeInsets.all(10.00),
                  ),
                  child: const Text('Create payment'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]));
  }
}
