import 'package:flutter/material.dart';
import 'package:jaijaoni/components/utils/profile_circle_avatar.dart';

import '../../screens/friend_profile.dart';

class DebtPeopleItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final String? profileImage;
  final int position;
  const DebtPeopleItem(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.profileImage,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FriendProfile(
                      fid: id,
                    )));
      },
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ProfileCircleAvatar(userId: id),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: Theme.of(context).textTheme.titleSmall),
                        Text(
                          "$price THB",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ]),
                ],
              ),
              if (position < 4 && position > 0)
                CircleAvatar(
                  foregroundImage: AssetImage(
                      "images/analysis/${position == 1 ? "1st" : position == 2 ? "2nd" : "3rd"}.png"),
                )
            ],
          ),
          SizedBox(
            height: 1,
            child: Container(color: Theme.of(context).colorScheme.outline),
          )
        ],
      ),
    );
  }
}
