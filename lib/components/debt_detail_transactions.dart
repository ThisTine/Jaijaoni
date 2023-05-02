import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransCard extends ConsumerStatefulWidget {
  final String date;
  final Color? circleColor;
  final String amount;

  const TransCard({
    Key? key,
    required this.date,
    required this.circleColor,
    required this.amount,
  }) : super(key: key);

  @override
  ConsumerState<TransCard> createState() => _TransCardState();
}

class _TransCardState extends ConsumerState<TransCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.date, // เปลี่ยนเป็น date
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.fontSize),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ClipOval(
                          child: Container(
                        color: widget.circleColor,
                        width: 12,
                        height: 12,
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_drop_up,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.amount,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.fontSize)),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
