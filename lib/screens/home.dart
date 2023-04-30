//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/home_card.dart';
import 'package:jaijaoni/components/home_collect_chart.dart';
import 'package:jaijaoni/components/home_collect_detail.dart';
import 'package:jaijaoni/components/home_paid_chart.dart';
import 'package:jaijaoni/components/home_paid_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> lendList = [
    {
      "id": 1,
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
  ];

  List<Map<String, dynamic>> foundList = [];
  bool isVisible = true;
  // turn Chart & Detail visible/invisible
  @override
  initState() {
    foundList = lendList;
    // need to add borrowList
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = lendList;
      isVisible = true;
      // if no enteredkeyword show all debt cards normally
      // need to add borrowList
    } else {
      results = lendList
          .where((debt) =>
              debt["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // .toLowerCase() to make it case-insensitive
      isVisible = false;
      // need to add borrowList
    }
    setState(() {
      foundList = results;
      // take the results and add it to the foundList, this will enable us to show the found card
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(28)),
                    color: Theme.of(context).colorScheme.primaryContainer),
                width: 360,
                height: 56,
                child: TextField(
                    onChanged: (value) => runFilter(value),
                    decoration: const InputDecoration(
                        hintText: "Hinted search text",
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.all(20))),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Visibility(
                        visible: isVisible,
                        child: const CollectChart(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Visibility(
                            visible: isVisible, child: const CollectDetail())),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Visibility(
                        visible: isVisible,
                        child: const PaidChart(),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Visibility(
                            visible: isVisible, child: const PaidDetail())),
                  ]),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 360,
                      child: ListView.builder(
                          itemCount: foundList.length,
                          itemBuilder: (context, index) {
                            return HomeCard(
                              key: ValueKey(foundList[index]["id"]),
                              name: foundList[index]["name"],
                              date: foundList[index]["date"],
                              amount: foundList[index]["amount"],
                              image: foundList[index]["image"],
                              debtor: foundList[index]["debtor"],
                            );
                          })))
            ],
          ),
        ),
      ),
    );
  }
}
