import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayerCard extends ConsumerStatefulWidget {
  final String name;
  final Color? circleColor;
  final String image;
  final String amount;
  final String? days;

  const PayerCard({
    Key? key,
    required this.name,
    required this.circleColor,
    required this.image,
    required this.amount,
    this.days,
  }) : super(key: key);

  @override
  ConsumerState<PayerCard> createState() => _PayerCardState();
}

class _PayerCardState extends ConsumerState<PayerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _receipt(context),
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
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                        ClipOval(
                            child: Container(
                          color: widget.circleColor,
                          width: 12,
                          height: 12,
                        )),
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
                  Text(widget.amount,
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

Future<void> _receipt(BuildContext context) {
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
            Image.asset(
              "images/receipt.jpg",
            ),
            const SizedBox(height: 20),
            const Text("Amount: 5000 THB")
          ]),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Decline'),
            onPressed: () {
              Navigator.of(context).pop();
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
