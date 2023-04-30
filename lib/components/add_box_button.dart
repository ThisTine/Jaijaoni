import 'package:flutter/material.dart';

class AddBoxButton extends StatelessWidget {
  const AddBoxButton({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 82,
      margin: const EdgeInsets.all(10),
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
      ),
    );
  }
}
