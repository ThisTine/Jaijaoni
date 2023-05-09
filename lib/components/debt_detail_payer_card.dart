import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/circle_avata.dart';
import 'package:jaijaoni/functions/home/get_bill.dart';

class PayerCard extends ConsumerStatefulWidget {
  final String name;
  // final Color? circleColor;
  final String id;
  final String circleColorState;
  final String image;
  final double amount;
  final String? days;

  // final bool done;

  const PayerCard({
    Key? key,
    required this.name,
    required this.image,
    required this.amount,
    // required this.done,
    required this.circleColorState,
    required this.id,
    this.days,
  }) : super(key: key);

  @override
  ConsumerState<PayerCard> createState() => _PayerCardState();
}

class _PayerCardState extends ConsumerState<PayerCard> {
  String profileImage = '';
  String billImage = '';
  @override
  void initState() {
    _getprofile();
    _getbill();
    super.initState();
  }

  _getprofile() async {
    await picFrined(widget.image).then((value) => setState(() {
          profileImage = value;
        }));
  }

  _getbill() async {
    await getBill(widget.id).then((value) => setState(() {
          billImage = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (widget.circleColorState == "pending") ...[
          _receiptAlert(context, billImage)
        ]
        // else if (widget.circleColor ==
        //     Theme.of(context).colorScheme.error) ...[
        //   _wrongAlert(context)
        // ]
      },
      child: Container(
        width: 358,
        height: 82,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.secondaryContainer,
            boxShadow: [
              BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5))
            ]),
        child: Row(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                if (widget.circleColorState == "success") ...[
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30),
                      child: Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ] else ...[
                  // fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(30),
                      child: Image.network(
                        billImage,
                        fit: BoxFit.cover,
                        color: Colors.white.withOpacity(0.5),
                        colorBlendMode: BlendMode.modulate,
                      ),
                    ),
                  ),
                ],
                const SizedBox(
                  width: 13,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        if (widget.circleColorState == "pending") ...[
                          ClipOval(
                              child: Container(
                            color: Theme.of(context).colorScheme.primary,
                            width: 12,
                            height: 12,
                          )),
                        ] else if (widget.circleColorState == "error") ...[
                          ClipOval(
                              child: Container(
                            color: Theme.of(context).colorScheme.error,
                            width: 12,
                            height: 12,
                          )),
                        ] else if (widget.circleColorState == "success")
                          ...[]
                      ],
                    ),
                    Row(
                      children: [
                        if (widget.days == null) ...[
                          // const Text("")
                        ] else ...[
                          Text(
                            "sent picture ${widget.days} days ago",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.fontSize),
                            maxLines: 1,
                          ),
                        ]
                      ],
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.paid,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.amount.toString(),
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize)),
                  const SizedBox(
                    width: 13,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _receiptAlert(BuildContext context, String bill) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // insetPadding:
        //     const EdgeInsets.only(top: 150, bottom: 150, left: 50, right: 50),
        title: const Text('Receipt'),
        content: SizedBox(
          width: 300,
          height: 500,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.network(
              bill,
            ),
            const SizedBox(height: 20),
            const Text("Amount: 5000 THB")
          ]),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            child: const Text('Decline'),
            onPressed: () {
              Navigator.of(context).pop();
              _wrongAlert(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _wrongAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // insetPadding:
        //     const EdgeInsets.only(top: 150, bottom: 150, left: 50, right: 50),
        title: const Text("What's wrong with this receipt?"),
        content: Container(
            alignment: Alignment.center,
            width: 300,
            height: 500,
            child: const TextField(
                decoration: InputDecoration(
                    labelText: "Reasons",
                    contentPadding: EdgeInsets.all(20),
                    fillColor: Color.fromRGBO(0, 0, 0, 0.05),
                    filled: true))),
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
            child: const Text('Send'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
