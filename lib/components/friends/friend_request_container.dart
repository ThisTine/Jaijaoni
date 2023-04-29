import 'package:flutter/material.dart';

import 'friend_item.dart';

class FriendRequestContainer extends StatelessWidget {
  const FriendRequestContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 10; i++)
          const FriendItem(
            name: "Sittichok",
            username: "@thistine",
            isRequest: true,
          )
      ],
    );
  }
}
