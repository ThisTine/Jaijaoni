import 'package:flutter/material.dart';
import 'package:jaijaoni/model/user.model.dart';

import 'friend_item.dart';

class FriendListContainer extends StatelessWidget {
  final String searchData;
  final List<Users> friends;

  const FriendListContainer(
      {super.key, required this.searchData, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...friends
            .where((element) =>
                // element['isRequest'] == false &&
                (searchData.toString().startsWith('@') ? true : true) &&
                (searchData.toString().startsWith('@')
                    ? element.username.toString() == searchData
                    : element.name.toString().contains(searchData)))
            .toList()
            .asMap()
            .map((key, value) => MapEntry(
                key,
                FriendItem(
                  getData: () {},
                  id: value.userId,
                  name: value.name,
                  profile: "https://i.pravatar.cc/150?img=${value.userId}",
                  username: value.username,
                  isFriend: true,
                )))
            .values
            .toList()
      ],
      // for (int i = 0; i < 10; i++)
      //   const FriendItem(
      //       id: "test",
      //       name: "Sittichok",
      //       username: "@thistine",
      //       isFriend: true)
    );
  }
}
