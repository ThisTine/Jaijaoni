//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/home/home_collect_chart.dart';
import 'package:jaijaoni/functions/home/get_borrow.dart';
import 'package:jaijaoni/functions/home/get_lead.dart';
import 'package:jaijaoni/functions/utils/find_debt_by_user_id.dart';
import 'package:jaijaoni/providers/friends/show_snackbar.dart';
import '../components/home/home_borrow_card.dart';
import '../components/home/home_collect_detail.dart';
import '../components/home/home_lend_card.dart';
import '../components/home/home_paid_chart.dart';
import '../components/home/home_paid_detail.dart';
import '../model/debt.model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final List<Map<String, dynamic>> lendList = [
  //   {
  //     "id": 1,
  //     // "cardColor": const Color(0xFF5DB08D),
  //     // Can not use {Theme.of(context).colorScheme.primary,} because of {context}
  //     "name": "Bonchon Chicken",
  //     "date": "3/04/23",
  //     "amount": "1000",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 3
  //   },
  //   {
  //     "id": 2,
  //     "name": "ส้มตำร้านเด็ด",
  //     "date": "7/04/23",
  //     "amount": "700",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 5
  //   },
  //   {
  //     "id": 3,
  //     "name": "KFB เจ้าดัง",
  //     "date": "12/04/23",
  //     "amount": "540",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 1
  //   },
  //   {
  //     "id": 4,
  //     "name": "ตี๋น้อย",
  //     "date": "13/04/23",
  //     "amount": "870",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 4
  //   },
  //   {
  //     "id": 5,
  //     "name": "Pizza Company",
  //     "date": "15/04/23",
  //     "amount": "430",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 3
  //   },
  // ];

  // final List<Map<String, dynamic>> borrowlist = [
  //   {
  //     "id": 1,
  //     "name": "Seven Eleven",
  //     "date": "4/04/23",
  //     "amount": "350",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 5
  //   },
  //   {
  //     "id": 2,
  //     "name": "ปะแหล่ม",
  //     "date": "5/04/23",
  //     "amount": "350",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 4
  //   },
  //   {
  //     "id": 3,
  //     "name": "Mc Donald",
  //     "date": "7/04/23",
  //     "amount": "350",
  //     "image": "images/profile/dazai.jpg",
  //     "debtor": 2
  //   },
  // ];

  List<Map<String, dynamic>>? lendList;
  List<Map<String, dynamic>>? borrowlist;
  List<Map<String, dynamic>> foundLend = [];
  List<Map<String, dynamic>> foundBorrow = [];
  // int totalDebtor = 0;
  bool isVisible = true;
  bool isLoading = true;
  // turn Chart & Detail visible/invisible
  @override
  initState() {
    _getlend();
    // foundLend = lendList;
    // foundBorrow = borrowlist;
    // need to add borrowList
    // for (var e in lendList!) {
    //   totalDebtor += e["debtor"]! as int;
    // }
    super.initState();
  }

  _getlend() async {
    await getLend()
        .then((value) => setState(() {
              lendList = value;
            }))
        .onError(
            (error, stackTrace) => showSnackBar(context, error.toString()));
    await getBow()
        .then((value) => setState(() {
              borrowlist = value;
            }))
        .onError(
            (error, stackTrace) => showSnackBar(context, error.toString()));
    setState(() {
      runFilter("");
      isLoading = false;
    });
    print(isLoading);
  }

  void runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> lendResults = [];
    List<Map<String, dynamic>> borrowResults = [];
    if (enteredKeyword.isEmpty) {
      lendResults += lendList!;
      borrowResults += borrowlist!;
      isVisible = true;
      // if no enteredkeyword show all debt cards normally
      // need to add borrowList
    } else {
      lendResults += lendList!
          .where((debt) =>
              debt["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      borrowResults += borrowlist!
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
    if (isLoading) {
      return Scaffold(
          appBar: customAppBarBuilder(context, text: "Home", backButton: false),
          body: Stack(children: [
            SingleChildScrollView(
                child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [Center(child: Text('Loading...'))],
              ),
            ))
          ]));
    } else {
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
                      // runFilter
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
                        flex: 10,
                        child: Visibility(
                          visible: isVisible,
                          child: const CollectChart(),
                        ),
                      ),
                      Flexible(
                          flex: 8,
                          child: Visibility(
                              visible: isVisible,
                              child: const CollectDetail())),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 10,
                        child: Visibility(
                          visible: isVisible,
                          child: const PaidChart(),
                        ),
                      ),
                      Flexible(
                          flex: 8,
                          child: Visibility(
                              visible: isVisible, child: const PaidDetail())),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 230,
                  child: SegmentedButton<int>(
                    segments: const <ButtonSegment<int>>[
                      ButtonSegment<int>(
                        value: 0,
                        label: Text('Lend'),
                      ),
                      ButtonSegment<int>(
                        value: 1,
                        label: Text('   Borrow'),
                      )
                    ],
                    selected: <int>{cardView},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        cardView = newSelection.first;
                      });
                    },
                  ),
                ),
                cardView == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                            // height: MediaQuery.of(context).size.height,
                            width: 360,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: foundLend.length,
                                itemBuilder: (context, index) {
                                  var tsdate = foundLend[index]["date"];
                                  return LendCard(
                                    id: foundLend[index]["id"],
                                    name: foundLend[index]["name"],
                                    date:
                                        "${tsdate.day}/${tsdate.month}/${tsdate.year}",
                                    amount: foundLend[index]["amount"],
                                    image: foundLend[index]["image"],
                                    debtor: foundLend[index]["debtor"],
                                  );
                                })))
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                            // height: MediaQuery.of(context).size.height,
                            width: 360,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: foundBorrow.length,
                                itemBuilder: (context, index) {
                                  var tsdate = foundBorrow[index]["date"];
                                  return BorrowCard(
                                    id: foundBorrow[index]["id"],
                                    name: foundBorrow[index]["name"],
                                    date:
                                        "${tsdate.day}/${tsdate.month}/${tsdate.year}",
                                    amount: foundBorrow[index]["amount"],
                                    image: foundBorrow[index]["image"],
                                    debtor: foundBorrow[index]["debtor"],
                                  );
                                }))),
              ],
            ),
          ),
        ),
      );
    }
  }
}
