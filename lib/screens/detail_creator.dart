import 'package:flutter/material.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/detail_card.dart';
import 'package:jaijaoni/model/debt.model.dart';

import '../components/custom_app_bar.dart';

class DetailCreator extends StatefulWidget {
  final Debts debt;
  final Function deleteDebt;
  const DetailCreator(
      {super.key, required this.debt, required this.deleteDebt});

  @override
  State<DetailCreator> createState() => _DetailCreatorState();
}

class _DetailCreatorState extends State<DetailCreator> {
  late DateTime _date;

  void initData() {
    _date = DateTime.fromMillisecondsSinceEpoch(widget.debt.due.seconds * 1000);

    // for (var e in widget.debt.transactions) {
    //   print("id: ${e.username} amount: ${e.amount}");
    // }
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  totalPaidTransactions() {
    double total = 0;

    for (var e in widget.debt.transactions) {
      // print(widget.debt.transactions);
      // print(widget.debt.transactions.map((e) => {e.amount, e.isApproved}));
      if (e.isApproved == "success") {
        total += e.amount;
      }
    }
    return total;
  }

  createPayerCard() {
    if (widget.debt.transactions.isNotEmpty) {
      // for (var e in widget.debt.transactions) {
      return widget.debt.transactions
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: PayerCard(
                  tId: e.transactionId,
                  dId: widget.debt.debtId,
                  name: e.username,
                  // image: e.username,
                  amount: e.amount,
                  circleColorState: e.isApproved,
                  reason: e.errMessage,
                ),
              ))
          .toList();
      // }
    } else {
      return const [Text('')];
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600)),
            content: Container(
                alignment: Alignment.center,
                width: 300,
                height: 100,
                child: Text("Are you sure you want to delete this debt?",
                    style: Theme.of(context).textTheme.bodyLarge)),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  widget.deleteDebt();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBarBuilder(context, text: "Debt Detail", backButton: true),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                                  text: widget.debt.borrowersUserId.length
                                      .toString(),
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
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                                        text:
                                            totalPaidTransactions().toString(),
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
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
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
                                        text: (widget.debt.transactions)
                                            .where((e) =>
                                                e.isApproved == "pending")
                                            .map((e) => e.amount)
                                            .fold(
                                                0.0,
                                                (value, element) =>
                                                    value + element)
                                            .toStringAsFixed(2),
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
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      ...createPayerCard(),
                      const SizedBox(height: 100)
                    ],
                  ),
                ],
              ),
            )),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.all(10.00),
                    ),
                    onPressed: () => {_dialogBuilder(context)},
                    child: const Text(
                      "Delete Debt",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
