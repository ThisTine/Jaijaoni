import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/debt_detail_transactions.dart';
import 'package:jaijaoni/model/debt.model.dart';
import '../components/circle_avata.dart';
import '../components/custom_app_bar.dart';
import '../components/detail_card.dart';

class DetailCustomer extends StatefulWidget {
  final Debts debt;
  const DetailCustomer({super.key, required this.debt});

  @override
  State<DetailCustomer> createState() => _DetailCustomerState();
}

class _DetailCustomerState extends State<DetailCustomer> {
  String profileImage = '';
  late DateTime _date;

  void initData() {
    _date = DateTime.fromMillisecondsSinceEpoch(widget.debt.due.seconds * 1000);
  }

  @override
  void initState() {
    _getprofile();
    super.initState();
    initData();
  }

  _getprofile() async {
    await picFrined(widget.debt.userId).then((value) => setState(() {
          profileImage = value;
        }));
  }

  createTransCard() {
    return (widget.debt.transactions
        .map((e) => TransCard(
              error: e.errMessage,
              dId: widget.debt.debtId,
              amount: e.amount,
              date: widget.debt.due.seconds,
              status: e.isApproved,
            ))
        .toList());
    // return (TransCard(
    //   status: widget.debt.status,
    //   dId: widget.debt.debtId,
    //   amount: widget.debt.debtTotal,
    //   date: widget.debt.due.seconds,
    // ));
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
                        child: ClipOval(
                          child: SizedBox.fromSize(
                              size: const Size.fromRadius(30),
                              child: profileImage != ''
                                  ? Image.network(
                                      profileImage, //"images/profile/dazai.jpg",
                                      // widget.image,
                                      fit: BoxFit.cover,
                                    )
                                  : const CircleAvatar(
                                      child: Icon(Icons.person))),
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
                    children: [...createTransCard()],
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
                      // fixedSize: const Size(400, 40)
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.all(10.00),
                    ),
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
                ))
          ],
        ));
  }
}
