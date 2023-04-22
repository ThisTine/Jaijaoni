import 'package:flutter/material.dart';

class PayerItemUnpaid extends StatelessWidget {
  const PayerItemUnpaid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 13,
                ),
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(30), // Image radius
                    child: Image.network("images/profile/dazai.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
                Text(
                  'Muaymi',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium?.fontSize),
                ),
              ],
            ),
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
                Text("2000",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
    );
  }
}
