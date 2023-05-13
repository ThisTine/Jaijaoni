import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/friends/remove_friend.dart';
import 'package:jaijaoni/providers/friends/show_snackbar.dart';

AlertDialog unfriendAlert(BuildContext context, String name) {
  return AlertDialog(
    title: Text(
      "Unfriend @$name",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    content: Text("Are you sure you want to remove @$name from your friend?"),
    actions: [
      ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancel")),
      FilledButton(
          onPressed: () {
            removeFriend(name).then((value) {
              Navigator.pop(context, true);
            }).onError((error, stackTrace) {
              showSnackBar(context, error.toString());
              Navigator.pop(context, true);
            });
          },
          child: const Text("Unfriend"))
    ],
  );
}
