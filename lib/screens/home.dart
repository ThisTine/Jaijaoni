//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/home_card.dart';

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
              const Text("Test Text", style: TextStyle(fontSize: 30)),
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
