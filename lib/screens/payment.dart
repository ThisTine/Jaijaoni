//Gun
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/payment/payment_detail.dart';
import 'package:jaijaoni/components/payment/payment_form.dart';
import '../components/custom_app_bar.dart';

class PaymentScreen extends ConsumerWidget {
  final String debtId;
  const PaymentScreen({super.key,this.debtId = ""});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
            Paymentform(
              formKey: formKey,
              amount: amount,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PaymentDetail(
                            amounts: double.parse(amount.text),
                          );
                        }));
                      }
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.all(10.00),
                    ),
                    child: const Text('Create payment '),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ])),
    );
  }
}
