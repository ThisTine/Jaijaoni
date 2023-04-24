import 'package:flutter/material.dart';

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
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  labelText: 'Name',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 23,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  labelText: 'Due Date',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            const SizedBox(
              height: 23,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 25),
                  labelText: 'Price per person',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            )
          ],
        )));
  }
}
