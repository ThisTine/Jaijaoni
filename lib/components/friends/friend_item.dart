import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  final bool isFriend;
  final String name;
  final String username;
  final String profile;
  const FriendItem(
      {super.key,
      this.isFriend = false,
      required this.name,
      required this.username,
      this.profile = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(foregroundImage: NetworkImage(profile)),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      username,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  isFriend
                      ? Icons.person_remove_outlined
                      : Icons.person_add_alt_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ],
        ),
      ],
    );
  }
}
