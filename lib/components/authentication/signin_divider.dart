import 'package:flutter/material.dart';

class SignInDivider extends StatelessWidget {
  final String text;
  const SignInDivider({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: 1,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text("or sign in with",
            style: Theme.of(context).textTheme.bodyMedium!.merge(
                TextStyle(color: Theme.of(context).colorScheme.outline))),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.outlineVariant,
            height: 1,
          ),
        ),
      ],
    );
  }
}
