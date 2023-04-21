import 'package:flutter/material.dart';
//Muaymi

import '../components/custom_app_bar.dart';
import '../components/debtForm.dart';

class CreateDebtScreen extends StatelessWidget {
  const CreateDebtScreen({super.key});

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
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.primary)),
              child: Text(
                'Next',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            )
          ],
        ));
  }
}
