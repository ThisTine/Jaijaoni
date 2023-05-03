import 'package:flutter/material.dart';

class AddBoxButton extends StatelessWidget {
  const AddBoxButton({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
        )
      ],
    );
  }
}
