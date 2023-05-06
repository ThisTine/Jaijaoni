import 'package:flutter/material.dart';
import 'package:jaijaoni/components/friends/friend_item.dart';
import 'package:jaijaoni/model/friends_req.model.dart';
import 'package:jaijaoni/model/user.model.dart';


class UsernameSearch extends StatefulWidget {
  final Users? usr;
  final FriendsReqs? request;
  final bool isLoading;
  final Function getData;

  const UsernameSearch({
    super.key,
    required this.getData,
    required this.usr,
    required this.request,
    required this.isLoading
  });

  @override
  State<UsernameSearch> createState() => _UsernameSearchState();
}

class _UsernameSearchState extends State<UsernameSearch> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       widget.isLoading ? const CircularProgressIndicator() : (widget.usr != null)
            ? FriendItem(
              getData: widget.getData,
                id: widget.usr!.userId,
                name: widget.usr!.name,
                profile: "https://i.pravatar.cc/150?img=${widget.usr!.userId}",
                username: widget.usr!.username,
                isFriend: widget.request != null && (widget.request!.status == "accepted"),
                isRequest: widget.request != null && widget.request!.status == "requested",
                isRequestSent: widget.request != null && widget.request!.anotherUsername == widget.usr!.username,

              )
            : const Text("Couldn't find user with this username")
      ],
      // for (int i = 0; i < 10; i++)
      //   const FriendItem(
      //       id: "test",
      //       name: "Sittichok",
      //       username: "@thistine",
      //       isFriend: true)
    );
  }
}
