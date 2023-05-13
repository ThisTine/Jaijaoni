import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/friends/add_person_to_friend.dart';

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
          onPressed: () async {
            addPersonToFriend(name).then((value) {
              Navigator.pop(context, true);
            }).onError((error, stackTrace) {
              Navigator.pop(context, true);
            });
          },
          child: const Text("Add friend"))
    ],
  );
}
