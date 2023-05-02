//Tine
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/friends/friend_list_container.dart';
import 'package:jaijaoni/components/friends/friend_request_container.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';
import 'package:jaijaoni/screens/addfriend.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final TextEditingController _searchController =
      TextEditingController(text: "");
  String toggleMode = "FRIEND_LIST";
  void openQR() async {
    String data = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddFriendScreen()));
    if (data != "") {
      setState(() {
        toggleMode = "FRIEND_LIST";
        _searchController.text = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context,
          text: "Friends",
          backButton: true,
          actions: [
            IconButton(
                onPressed: () {
                  openQR();
                },
                icon: Icon(
                  Icons.qr_code,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 576, minHeight: MediaQuery.of(context).size.height),
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
                    selected: {toggleMode},
                    onSelectionChanged: (p0) {
                      setState(() {
                        toggleMode = p0.first;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: roundInput.copyWith(
                          labelText: "Search",
                          hintText: "Friend's name or username",
                          suffixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  toggleMode.contains("FRIEND_LIST")
                      ? FriendListContainer(
                          searchData: _searchController.text,
                        )
                      : FriendRequestContainer(
                          searchData: _searchController.text,
                        )
                  // FriendItem(),
                  // FriendItem(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
