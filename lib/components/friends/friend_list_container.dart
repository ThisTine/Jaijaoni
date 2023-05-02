import 'package:flutter/material.dart';

import 'friend_item.dart';
import 'friend_mock_data.dart';

class FriendListContainer extends StatelessWidget {
  final String searchData;
  const FriendListContainer({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...friendList
            .where((element) =>
                element['isRequest'] == false &&
                (searchData.toString().startsWith('@')
                    ? true
                    : element['isFriend'] == true) &&
                (searchData.toString().startsWith('@')
                    ? element['username'].toString() == searchData
                    : element['name'].toString().contains(searchData)))
            .toList()
            .asMap()
            .map((key, value) => MapEntry(
                key,
                FriendItem(
                  id: key.toString(),
                  name: value['name'],
                  profile: "https://i.pravatar.cc/150?img=${value['username']}",
                  username: value['username'],
                  isFriend: value['isFriend'],
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
