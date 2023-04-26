import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'profile.dart';

class FriendProfile extends StatelessWidget {
  final String fid;
  const FriendProfile({super.key, required this.fid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context,
          text: "Friend profile", backButton: true),
      body: Center(
        child: Column(
          children: [
            CircleAvata(radius: 50),
          ],
        ),
      ),
    );
    ;
  }
}
