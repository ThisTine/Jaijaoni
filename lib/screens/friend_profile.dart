import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import '../components/circleAvata.dart';

class FriendProfile extends StatelessWidget {
  final String fid;
  const FriendProfile({super.key, required this.fid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context,
          text: "Friend profile", backButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  circleAvata(radius: 80),
                  cardProfile(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardProfile(BuildContext context) {
  return (Container(
    width: 330,
    height: 400,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: Theme.of(context).colorScheme.secondaryContainer),
    child: Column(
      children: [
        Text("muaymi🍅",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize)),
      ],
    ),
  ));
}
