import 'package:flutter/material.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';
import 'firend_list.dart';

class FriendBottomsheet extends StatefulWidget {
  const FriendBottomsheet(
      {super.key, required this.handleSelectFriend, required this.peopleList});
  final Function handleSelectFriend;
  final List<SelectedFirend> peopleList;

  @override
  State<FriendBottomsheet> createState() => _FriendBottomsheetState();
}

class _FriendBottomsheetState extends State<FriendBottomsheet> {
  List<SelectedFirend> newPeopleList = [];
  String _searchText = "";
  @override
  void initState() {
    super.initState();
    setState(() {
      newPeopleList = widget.peopleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 2 - 72,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.search),
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Expanded(
                child: FriendList(
                    searchText: _searchText,
                    peopleList: newPeopleList,
                    handleSelectPeople: (newValue) {
                      setState(() {
                        newPeopleList = newValue;
                      });
                    }),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      widget.handleSelectFriend(newPeopleList);
                      Navigator.pop(context);
                    },
                    child: Text(
                      newPeopleList.isEmpty
                          ? 'Clear People'
                          : 'Add ${newPeopleList.length} ${newPeopleList.length == 1 ? "Person" : "People"}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
