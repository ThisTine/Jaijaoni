import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/detail_card.dart';
import 'package:jaijaoni/model/debt.model.dart';

import '../components/custom_app_bar.dart';

class DetailCreator extends StatefulWidget {
  final Debts debt;
  const DetailCreator({super.key, required this.debt});

  @override
  State<DetailCreator> createState() => _DetailCreatorState();
}

class _DetailCreatorState extends State<DetailCreator> {
  late DateTime _date;
  late double _unpaid;

  void initData() {
    _date = DateTime.fromMillisecondsSinceEpoch(widget.debt.due.seconds * 1000);

    for (var e in widget.debt.transactions) {
      print("id: ${e.username} amount: ${e.amount}");
    }

    // _transactions[0]["amount"];
    // List<Map<String, dynamic>> trans = widget.debt.transactions;
  }

  @override
  void initState() {
    super.initState();
    initData();
    _unpaid = widget.debt.debtTotal - totalPaidTransactions();
  }

  totalPaidTransactions() {
    double total = 0;
    for (var e in widget.debt.transactions) {
      total += e.amount;
    }
    return total;
  }

  createPayerCard() {
    if (widget.debt.transactions.isNotEmpty) {
      for (var e in widget.debt.transactions) {
        return PayerCard(
          name: e.username,
          image: e.profilePic,
          amount: e.amount,
          circleColorState: e.isApproved,
        );
      }
    } else {
      return const Text('');
    }
  }

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
                id: widget.debt.debtId,
                cardColor: Theme.of(context).colorScheme.primary,
                name: widget.debt.debtName,
                amount: widget.debt.debtTotal.toString(),
                edit: true),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23),
                          child: Icon(Icons.alarm,
                              size: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  // Date Text
                                  text:
                                      "${_date.day}/${_date.month}/${_date.year}", //"Tue, Feburary 2023",
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
                  width: 10,
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
                            text: widget.debt.borrowersUserId.length.toString(),
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
                                  text: totalPaidTransactions().toString(),
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
                  width: 15,
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
                                  text: _unpaid.toString(),
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
                createPayerCard()
                // PayerCard(
                //   name: "Muaymiii",
                //   circleColor: Theme.of(context).colorScheme.primary,
                //   image: "images/profile/dazai.jpg",
                //   days: "3",
                //   amount: "200",
                //   done: false,
                // ),
                // const SizedBox(height: 13),
                // PayerCard(
                //   name: "Tine",
                //   circleColor: Theme.of(context).colorScheme.primary,
                //   image: "images/profile/dazai.jpg",
                //   amount: "250",
                //   days: "5",
                //   done: false,
                // ),
                // const SizedBox(height: 13),
                // PayerCard(
                //   name: "Dazaii",
                //   circleColor: Theme.of(context).colorScheme.error,
                //   image: "images/profile/dazai.jpg",
                //   amount: "150",
                //   days: "2",
                //   done: false,
                // ),
                // const SizedBox(height: 13),
                // PayerCard(
                //   name: "Fah",
                //   image: "images/profile/dazai.jpg",
                //   circleColor: Theme.of(context).colorScheme.error,
                //   amount: "150",
                //   days: "3",
                //   done: false,
                // ),
                // const SizedBox(height: 13),
                // const PayerCard(
                //   name: "Ri",
                //   image: "images/profile/dazai.jpg",
                //   amount: "100",
                //   done: false,
                // ),
                // const SizedBox(height: 13),
                // const PayerCard(
                //   name: "Gunn",
                //   image: "images/profile/dazai.jpg",
                //   amount: "150",
                //   done: true,
                // ),
                // const SizedBox(height: 13),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
