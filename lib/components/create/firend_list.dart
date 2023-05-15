import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/create/get_friends.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';

import 'friend_list_check.dart';
import 'selected_friend.dart';

class FriendList extends StatefulWidget {
  final String searchText;
  const FriendList(
      {super.key,
      required this.peopleList,
      required this.handleSelectPeople,
      required this.searchText});
  final List<SelectedFirend> peopleList;
  final Function handleSelectPeople;

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  bool _isLoading = true;
  List<SelectedFirend> friendList = [
    // SelectedFirend("001", "images/profile/dazai", "muaymi", 100),
    // SelectedFirend("002", "images/profile/dazai", "tine", 100),
    // SelectedFirend("003", "images/profile/dazai", "ri", 100),
    // SelectedFirend("004", "images/profile/dazai", "fah", 100),
    // SelectedFirend("005", "images/profile/dazai", "gun", 100),
    // SelectedFirend("006", "images/profile/dazai", "dazai", 100),
  ];

  @override
  void initState() {
    super.initState();

    getFriends(FirebaseAuth.instance.currentUser!.uid).then((value) {
      findUserById(FirebaseAuth.instance.currentUser!.uid).then((user) {
        if (mounted) {
          setState(() {
            friendList = [SelectedFirend(id: user.userId, imagePath: "", name: '${user.username} (You)', price: 0, username: user.name),...value
                .map((e) => SelectedFirend(
                    id: e.id,
                    imagePath: "",
                    name: e.name,
                    price: 0,
                    username: e.username))
                .toList()];
            _isLoading = false;
          });
        }
      });
    }).onError(
      (error, stackTrace) {
        // print(error);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: Text("Retrieving data..."));
    }
    return SingleChildScrollView(
      child: Wrap(
          children: friendList
              .where((element) => element.name.contains(widget.searchText))
              .map((e) => ListOfFriend(
                  id: e.id,
                  imagePath: "images/profile/dazai.jpg",
                  name: e.name,
                  check: widget.peopleList
                          .indexWhere((element) => element.id == e.id) !=
                      -1,
                  handleCheck: (check) {
                    if (check) {
                      widget.handleSelectPeople([...widget.peopleList, e]);
                    } else {
                      widget.handleSelectPeople(widget.peopleList
                          .where((element) => element.id != e.id)
                          .toList());
                    }
                  }))
              .toList()),
    );
  }
}
