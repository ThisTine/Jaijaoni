import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransCard extends ConsumerStatefulWidget {
  final String dId;
  final int date;
  final String status;
  final double amount;
  final String? error;

  const TransCard({
    Key? key,
    required this.status,
    required this.dId,
    required this.date,
    required this.amount,
    required this.error,
  }) : super(key: key);

  @override
  ConsumerState<TransCard> createState() => _TransCardState();
}

class _TransCardState extends ConsumerState<TransCard> {
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _date = DateTime.fromMillisecondsSinceEpoch(widget.date * 1000);
  }

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
                        "${_date.day}/${_date.month}/${_date.year}", // เปลี่ยนเป็น date
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
                        color: widget.status == "error"
                            ? Theme.of(context).colorScheme.error
                            : widget.status == "success"
                                ? Colors.green
                                : const Color(0xFFE8EB01), //widget.circleColor,
                        width: 12,
                        height: 12,
                      )),
                    ],
                  ),
                  if (widget.error != null && widget.error != "")
                    Text(
                      widget.error ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.red),
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
                  Icons.arrow_drop_up,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.amount.toString(),
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
