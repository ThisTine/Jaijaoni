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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailCard(name: "Bonchon Chicken", amount: "1000"),
            const SizedBox(
              width: 13,
            ),
            Text(
              "Payers",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PayerCard(
                    name: "Muaymiii",
                    circleColor: Theme.of(context).colorScheme.primary,
                    image: "images/profile/dazai.jpg",
                    amount: "200",
                    days: "3"),
                const SizedBox(height: 13),
                PayerCard(
                  name: "Tine",
                  circleColor: Theme.of(context).colorScheme.primary,
                  image: "images/profile/dazai.jpg",
                  amount: "300",
                  days: "5",
                ),
                const SizedBox(height: 13),
                PayerCard(
                    name: "Dazaii",
                    circleColor: Theme.of(context).colorScheme.error,
                    image: "images/profile/dazai.jpg",
                    amount: "400"),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
