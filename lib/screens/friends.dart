//Tine
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/friends/friend_item.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  Set<String> toggleMode = {"FRIEND_LIST"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Friends", backButton: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 576),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                SegmentedButton(
                  segments: const [
                    ButtonSegment(
                        value: "FRIEND_LIST", label: Text("Friend List")),
                    ButtonSegment(
                        value: "FRIEND_REQUEST", label: Text("Request"))
                  ],
                  selected: toggleMode,
                  onSelectionChanged: (p0) {
                    setState(() {
                      toggleMode = p0;
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    decoration: roundInput.copyWith(
                        labelText: "Search",
                        hintText: "Friend's name or username",
                        suffixIcon: const Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < 10; i++)
                  const FriendItem(
                      name: "Sittichok", username: "@thistine", isFriend: true),
                // FriendItem(),
                // FriendItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
