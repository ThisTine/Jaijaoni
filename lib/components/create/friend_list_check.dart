import 'package:flutter/material.dart';
import 'package:jaijaoni/components/utils/profile_circle_avatar.dart';

class ListOfFriend extends StatefulWidget {
  const ListOfFriend(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.name,
      required this.check,
      required this.handleCheck});
  final String id;
  final String imagePath;
  final String name;
  final bool check;
  final Function handleCheck;

  @override
  State<ListOfFriend> createState() => _ListOfFriendState();
}

class _ListOfFriendState extends State<ListOfFriend> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ProfileCircleAvatar(userId: widget.id),
      title: Text(widget.name),
      trailing: Checkbox(
          value: widget.check,
          onChanged: (bool? newValue) {
            widget.handleCheck(newValue);
          }),
    );
  }
}
