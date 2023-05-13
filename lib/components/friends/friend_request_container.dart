import 'package:flutter/material.dart';
import 'package:jaijaoni/model/user.model.dart';

import 'friend_item.dart';

class FriendRequestContainer extends StatelessWidget {
  final String searchData;
  final List<Users> friends;

  const FriendRequestContainer(
      {super.key, required this.searchData, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...friends
            .where((element) =>
                // element['isRequest'] == true &&
                (element.name.toString().contains(searchData) ||
                    element.username == searchData))
            .toList()
            .asMap()
            .map((key, value) => MapEntry(
                key,
                FriendItem(
                  getData: () {},
                  id: key.toString(),
                  name: value.name,
                  profile: "https://i.pravatar.cc/150?img=${value.userId}",
                  username: value.username,
                  isRequest: true,
                )))
            .values
            .toList()
      ],
    );
  }
}
