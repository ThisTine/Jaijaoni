import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/detail_card.dart';

import '../components/custom_app_bar.dart';

class DetailCreator extends StatefulWidget {
  const DetailCreator({super.key});

  @override
  State<DetailCreator> createState() => _DetailCreatorState();
}

class _DetailCreatorState extends State<DetailCreator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBarBuilder(context, text: "Debt Detail", backButton: true),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            DetailCard(
                cardColor: Theme.of(context).colorScheme.primary,
                name: "Bonchon Chicken",
                amount: "1000"),
            const SizedBox(
              height: 23,
            ),
            Row(
              // Date, number of people
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // Date
                  width: 265,
                  height: 78,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  alignment: Alignment.center,
                  child: RichText(
                    // textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.alarm,
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        TextSpan(
                            // Date Text
                            text: "Tue, Feburary 2023",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.fontSize)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  // number of people
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.group_add_outlined,
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        TextSpan(
                            text: "\n10",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.fontSize)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              // Paid, Unpaid
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // Paid
                  width: 170,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23),
                          child: Icon(Icons.check_circle,
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        RichText(
                          // textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "400",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.fontSize)),
                            ],
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  width: 23,
                ),
                Container(
                  // Un-Paid
                  width: 170,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(1, 1),
                            color: Colors.grey.withOpacity(0.5))
                      ]),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23),
                          child: Icon(Icons.hourglass_top,
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        RichText(
                          // textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "600",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.fontSize)),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Payers",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PayerCard(
                  name: "Muaymiii",
                  circleColor: Theme.of(context).colorScheme.primary,
                  image: "images/profile/dazai.jpg",
                  days: "3",
                  amount: "200",
                  done: false,
                ),
                const SizedBox(height: 13),
                PayerCard(
                  name: "Tine",
                  circleColor: Theme.of(context).colorScheme.primary,
                  image: "images/profile/dazai.jpg",
                  amount: "250",
                  days: "5",
                  done: false,
                ),
                const SizedBox(height: 13),
                PayerCard(
                  name: "Dazaii",
                  circleColor: Theme.of(context).colorScheme.error,
                  image: "images/profile/dazai.jpg",
                  amount: "150",
                  days: "2",
                  done: false,
                ),
                const SizedBox(height: 13),
                PayerCard(
                  name: "Fah",
                  image: "images/profile/dazai.jpg",
                  circleColor: Theme.of(context).colorScheme.error,
                  amount: "150",
                  days: "3",
                  done: false,
                ),
                const SizedBox(height: 13),
                const PayerCard(
                  name: "Ri",
                  image: "images/profile/dazai.jpg",
                  amount: "100",
                  done: false,
                ),
                const SizedBox(height: 13),
                const PayerCard(
                  name: "Gunn",
                  image: "images/profile/dazai.jpg",
                  amount: "150",
                  done: true,
                ),
                const SizedBox(height: 13),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
