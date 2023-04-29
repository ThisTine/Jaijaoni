import 'package:flutter/material.dart';

AlertDialog unfriendAlert(BuildContext context, String name) {
  return AlertDialog(
    title: Text(
      "Unfriend $name",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    content: Text("Are you sure you want to remove $name as your friend?"),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel")),
      FilledButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Unfriend"))
    ],
  );
}
