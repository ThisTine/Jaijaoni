//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/home_card.dart';
import 'package:jaijaoni/components/home_collect_chart.dart';
import 'package:jaijaoni/components/home_paid_chart.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 5,
                      child: CollectChart(),
                    ),
                    Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("8",
                                    style: TextStyle(
                                        color: const Color(0xFF5DB075),
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.fontSize,
                                        fontWeight: FontWeight.bold,
                                        height: 0.8)),
                                Text(" friends",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.fontSize,
                                        height: 0.8)),
                              ],
                            ),
                            Text("in debt to you.",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.fontSize)),
                            const SizedBox(
                              height: 12,
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF5DB075),
                                  fixedSize: const Size(125, 40)),
                              onPressed: () {},
                              child: const Text(
                                "more details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        )),
                  ]),

              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Flexible(
                      flex: 5,
                      child: PaidChart(),
                    ),
                    Flexible(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("6",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.fontSize,
                                        fontWeight: FontWeight.bold,
                                        height: 0.8)),
                                Text(" friends",
                                    style: TextStyle(
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.fontSize,
                                        height: 0.8)),
                              ],
                            ),
                            Text("you're in debt with.",
                                style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.fontSize)),
                            const SizedBox(
                              height: 12,
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  fixedSize: const Size(125, 40)),
                              onPressed: () {},
                              child: const Text(
                                "more details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        )),
                  ]),

              // const Text("Test Text", style: TextStyle(fontSize: 30)),

              const SizedBox(
                height: 20,
              ),
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
