import 'package:flutter/material.dart';

AlertDialog addfriendAlert(BuildContext context, String name) {
  return AlertDialog(
    title: Text(
      "Send $name a friend request",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    content: Text("Do you want to send $name a friend request."),
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
          child: const Text("Add friend"))
    ],
  );
}
