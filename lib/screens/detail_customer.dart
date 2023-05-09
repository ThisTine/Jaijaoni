import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/debt_detail_transactions.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/screens/payment.dart';
import '../components/custom_app_bar.dart';
import '../components/detail_card.dart';

class DetailCustomer extends StatefulWidget {
  final Debts debt;
  const DetailCustomer({super.key, required this.debt});

  @override
  State<DetailCustomer> createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  late DateTime _date;

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
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 55,
                  maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 13,
                  // ),
                  DetailCard(
                    id: widget.debt.debtId,
                    cardColor: Theme.of(context).colorScheme.primary,
                    name: widget.debt.debtName, //"Seven Eleven",
                    amount: widget.debt.debtTotal.toString(),
                    edit: false,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    // Date, number of people
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30),
                            child: Image.asset(
                              "images/profile/dazai.jpg",
                              // widget.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Transactions",
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
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      TransCard(
                          date: "23/03/2023",
                          circleColor: Color(0xFFE8EB01),
                          amount: "200")
                    ],
                  ),
                ],
              ),
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    fixedSize: const Size(355, 40)),
                onPressed: () => {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const PaymentScreen())
                  (context.go("/payment/${widget.debt.debtId}"))
                },
                child: const Text(
                  "Pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
