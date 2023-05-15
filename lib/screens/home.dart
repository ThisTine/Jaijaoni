//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/home/two_chart_in_home.dart';
import 'package:jaijaoni/functions/home/get_borrow.dart';
import 'package:jaijaoni/functions/home/get_lead.dart';
import 'package:jaijaoni/providers/friends/show_snackbar.dart';
import '../components/home/home_borrow_card.dart';
import '../components/home/home_lend_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>>? lendList = [];
  List<Map<String, dynamic>>? borrowlist = [];
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
              lendList!.sort((a, b) => a["date"].compareTo(b["date"]));
            }))
        .onError(
            (error, stackTrace) => showSnackBar(context, error.toString()));
    await getBow()
        .then((value) => setState(() {
              borrowlist = value;
              borrowlist!.sort((a, b) => a["date"].compareTo(b["date"]));
            }))
        .onError(
            (error, stackTrace) => showSnackBar(context, error.toString()));
    setState(() {
      runFilter("");
      isLoading = false;
    });
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
                TwoChartInHome(isVisible: isVisible),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 230,
                    child: lendList!.isNotEmpty
                        ? SegmentedButton<int>(
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
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: Text("You have no debt right now..",
                                style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138),
                                )),
                          )),
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
                                    profileId: foundLend[index]["profileId"],
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
                                    profileId: foundBorrow[index]["profileId"],
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
