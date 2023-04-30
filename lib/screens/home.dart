//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/home_card.dart';
import 'package:jaijaoni/components/home_collect_chart.dart';
import 'package:jaijaoni/components/home_collect_detail.dart';
import 'package:jaijaoni/components/home_paid_chart.dart';
import 'package:jaijaoni/components/home_paid_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _debts = [
      {
        "key": 1,
        "name": "Bonchon Chicken",
        "date": "3/04/23",
        "amount": "1000",
        "image": "images/profile/dazai.jpg",
        "debtor": 3
      },
      {
        "key": 2,
        "name": "ส้มตำร้านเด็ด",
        "date": "7/04/23",
        "amount": "700",
        "image": "images/profile/dazai.jpg",
        "debtor": 5
      },
      {
        "key": 3,
        "name": "KFB เจ้าดัง",
        "date": "12/04/23",
        "amount": "540",
        "image": "images/profile/dazai.jpg",
        "debtor": 1
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Flexible(
                      flex: 5,
                      child: CollectChart(),
                    ),
                    Flexible(flex: 3, child: CollectDetail()),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Flexible(
                      flex: 5,
                      child: PaidChart(),
                    ),
                    Flexible(flex: 3, child: PaidDetail()),
                  ]),

              // const Text("Test Text", style: TextStyle(fontSize: 30)),

              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 360,
                      child: ListView.builder(
                          itemCount: _debts.length,
                          itemBuilder: (context, index) {
                            return HomeCard(
                              key: ValueKey(_debts[index][key]),
                              name: _debts[index]["name"],
                              date: _debts[index]["date"],
                              amount: _debts[index]["amount"],
                              image: _debts[index]["image"],
                              debtor: _debts[index]["debtor"],
                            );
                          })))

              // PayerCard(
              //   name: "Muaymiiiiiiii",
              //   image: "images/profile/dazai.jpg",
              //   circleColor: Theme.of(context).colorScheme.primary,
              //   amount: "2000",
              //   days: "3",
              // ),

              // Container(
              //   child: Container(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              //     height: MediaQuery.of(context).size.height,
              //     // MediaQuery retrieve the device screen height size
              //     child: ListView.builder(
              //       itemCount: 10,
              //       itemBuilder: (context, index) {
              //         return const MyCard();
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
