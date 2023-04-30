//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/debt_detail_transactions.dart';
import 'package:jaijaoni/components/home_card.dart';
import 'package:jaijaoni/components/home_doughnut.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DoughnutChart(),
                    // const SizedBox(
                    //   width: 13,
                    // ),
                    Column(
                      children: const [
                        Text("Test 2", style: TextStyle(fontSize: 30)),
                      ],
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("Test 3", style: TextStyle(fontSize: 30)),
                    Column(
                      children: const [
                        Text("Test 4", style: TextStyle(fontSize: 30)),
                      ],
                    )
                  ]),
              // const Text("Test Text", style: TextStyle(fontSize: 30)),
              TransCard(
                  date: "3/23/2023",
                  circleColor: Theme.of(context).colorScheme.primary,
                  amount: "200"),

              PayerCard(
                name: "Muaymiiiiiiii",
                image: "images/profile/dazai.jpg",
                circleColor: Theme.of(context).colorScheme.primary,
                amount: "2000",
                days: "3",
              ),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
              HomeCard(),
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

class ChartData {
  ChartData(this.x, this.y, [this.color = Colors.white]);
  final String x;
  final double y;
  final Color color;
}
