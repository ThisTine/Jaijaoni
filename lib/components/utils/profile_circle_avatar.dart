import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/utils/get_image.dart';

class ProfileCircleAvatar extends StatelessWidget {
  final String userId;
  const ProfileCircleAvatar({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPicture(userId, "profile_pic"),
      builder: (context, snapshot) {
        return CircleAvatar(
          foregroundImage: NetworkImage(snapshot.data ?? ""),
          backgroundImage: const AssetImage("assets/profile.jpg"),
        );
      },
    );
  }
}
