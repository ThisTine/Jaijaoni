import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/payer_item_unpaid.dart';
//Muaymi

import '../components/custom_app_bar.dart';
import '../components/debt_form.dart';

class CreateDebtScreen extends ConsumerStatefulWidget {
  const CreateDebtScreen({super.key});

  @override
  ConsumerState<CreateDebtScreen> createState() => _CreateDebtScreenState();
}

class _CreateDebtScreenState extends ConsumerState<CreateDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarBuilder(context, text: "Create", backButton: true),
        body: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 16.0),
                Text(
                  'Debt Info',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize),
                ),
              ],
            ),
            const DebtForm(),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPeople()));
                },
                child: Text(
                  'Next',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ))
            // FilledButton(
            //   onPressed: () => const AddPeople(),
            //   style: ButtonStyle(
            //       backgroundColor: MaterialStateProperty.all<Color>(
            //           Theme.of(context).colorScheme.primary)),
            //   child: Text(
            //     'Next',
            //     style:
            //         TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            //   ),
            // )
          ],
        ));
  }
}

class AddPeople extends StatelessWidget {
  const AddPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarBuilder(context, text: "Create", backButton: true),
        body: Column(
          children: [
            Text('Who will be sharing?',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                )),
            const SizedBox(height: 20),
            Column(
              children: const [
                PayerItemUnpaid(),
                SizedBox(
                  height: 13,
                ),
                PayerItemUnpaid(),
              ],
            ),
          ],
        ));
  }
}
