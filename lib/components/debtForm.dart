import 'package:flutter/material.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';

class DebtForm extends StatelessWidget {
  const DebtForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: roundInput.copyWith(labelText: 'Name'),
            ),
            const SizedBox(
              height: 23,
            ),
            TextFormField(
                decoration: roundInput.copyWith(labelText: 'Due date')),
            const SizedBox(
              height: 23,
            ),
            TextFormField(
                decoration: roundInput.copyWith(labelText: 'Price per person'))
          ],
        )));
  }
}
