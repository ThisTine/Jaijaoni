import 'package:flutter/material.dart';

class BuildCards extends StatefulWidget {
  const BuildCards({super.key});

  @override
  State<BuildCards> createState() => _BuildCardsState();
}

class _BuildCardsState extends State<BuildCards> {
  final List<Map<String, dynamic>> lendList = [
    {
      "id": 1,
      // "cardColor": const Color(0xFF5DB08D),
      // Can not use {Theme.of(context).colorScheme.primary,} because of {context}
      "name": "Bonchon Chicken",
      "date": "3/04/23",
      "amount": "1000",
      "image": "images/profile/dazai.jpg",
      "debtor": 3
    },
    {
      "id": 2,
      "name": "ส้มตำร้านเด็ด",
      "date": "7/04/23",
      "amount": "700",
      "image": "images/profile/dazai.jpg",
      "debtor": 5
    },
    {
      "id": 3,
      "name": "KFB เจ้าดัง",
      "date": "12/04/23",
      "amount": "540",
      "image": "images/profile/dazai.jpg",
      "debtor": 1
    },
    {
      "id": 4,
      "name": "ตี๋น้อย",
      "date": "13/04/23",
      "amount": "870",
      "image": "images/profile/dazai.jpg",
      "debtor": 4
    },
    {
      "id": 5,
      "name": "Pizza Company",
      "date": "15/04/23",
      "amount": "430",
      "image": "images/profile/dazai.jpg",
      "debtor": 3
    },
  ];

  final List<Map<String, dynamic>> borrowlist = [
    {
      "id": 1,
      "name": "Seven Eleven",
      "date": "4/04/23",
      "amount": "350",
      "image": "images/profile/dazai.jpg",
      "debtor": 5
    },
    {
      "id": 2,
      "name": "ปะแหล่ม",
      "date": "5/04/23",
      "amount": "350",
      "image": "images/profile/dazai.jpg",
      "debtor": 4
    },
    {
      "id": 3,
      "name": "Mc Donald",
      "date": "7/04/23",
      "amount": "350",
      "image": "images/profile/dazai.jpg",
      "debtor": 2
    },
  ];

  List<Map<String, dynamic>> foundLend = [];
  List<Map<String, dynamic>> foundBorrow = [];
  bool isVisible = true;
  // turn Chart & Detail visible/invisible
  @override
  initState() {
    foundLend = lendList;
    foundBorrow = borrowlist;
    // need to add borrowList
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> lendResults = [];
    List<Map<String, dynamic>> borrowResults = [];
    if (enteredKeyword.isEmpty) {
      lendResults += lendList;
      borrowResults += borrowlist;
      isVisible = true;
      // if no enteredkeyword show all debt cards normally
      // need to add borrowList
    } else {
      lendResults += lendList
          .where((debt) =>
              debt["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      borrowResults += borrowlist
          .where((debt) =>
              debt["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      // .toLowerCase() to make it case-insensitive
      isVisible = false;
      // need to add borrowList
    }
    setState(() {
      foundLend = lendResults;
      foundBorrow = borrowResults;
      // take the results and add it to the foundList, this will enable us to show the found card
    });
  }

  int cardView = 0;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
