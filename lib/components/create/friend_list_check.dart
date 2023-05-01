import 'package:flutter/material.dart';

class ListOfFriend extends StatefulWidget {
  const ListOfFriend(
      {super.key,
      required this.id,
      required this.name,
      required this.check,
      required this.handleCheck});
  final String id;
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
      leading: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(20),
          child: Image.network("images/profile/dazai.jpg", fit: BoxFit.cover),
        ),
      ),
      title: Text(widget.name),
      trailing: Checkbox(
          value: widget.check,
          onChanged: (bool? newValue) {
            widget.handleCheck(newValue);
          }),
    );
  }
}
