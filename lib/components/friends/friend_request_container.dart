import 'package:flutter/material.dart';
import 'package:jaijaoni/components/friends/friend_mock_data.dart';

import 'friend_item.dart';

class FriendRequestContainer extends StatelessWidget {
  final String searchData;

  const FriendRequestContainer({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...friendList
            .where((element) =>
                element['isRequest'] == true &&
                (element['name'].toString().contains(searchData) ||
                    element['username'] == searchData))
            .toList()
            .asMap()
            .map((key, value) => MapEntry(
                key,
                FriendItem(
                  id: key.toString(),
                  name: value['name'],
                  profile: "https://i.pravatar.cc/150?img=${value['username']}",
                  username: value['username'],
                  isRequest: true,
                )))
            .values
            .toList()
      ],
    );
  }
}
