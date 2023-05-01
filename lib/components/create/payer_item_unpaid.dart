import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayerItemUnpaid extends ConsumerStatefulWidget {
  const PayerItemUnpaid(
      {super.key, required this.id, required this.name, required this.price});
  final String id;
  final String name;
  final double price;

  @override
  ConsumerState<PayerItemUnpaid> createState() => _PayerItemUnpaidState();
}

class _PayerItemUnpaidState extends ConsumerState<PayerItemUnpaid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
          Expanded(
            flex: 1,
            child: Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30),
                    child: Image.network("images/profile/dazai.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
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
                Flexible(
                  child: Text(widget.price.toStringAsFixed(2),
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.fontSize)),
                ),
                const SizedBox(
                  width: 13,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
