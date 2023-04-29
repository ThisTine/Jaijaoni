import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'friend_item.dart';

class FriendListContainer extends StatelessWidget {
  const FriendListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 10; i++)
          const FriendItem(
              id: "test",
              name: "Sittichok",
              username: "@thistine",
              isFriend: true)
      ],
    );
  }
}
