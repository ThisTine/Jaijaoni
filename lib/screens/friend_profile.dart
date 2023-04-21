import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';

class FriendProfile extends StatelessWidget {
  final String fid;
  const FriendProfile({super.key, required this.fid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Friend profile"),
      body: Center(
        child: Text("Friend user id : ${fid}"),
      ),
    );
    ;
  }
}
