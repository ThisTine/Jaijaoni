import 'package:flutter/material.dart';

class Paymentuploadsheet extends StatelessWidget {
  const Paymentuploadsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19), topRight: Radius.circular(19)),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: FilledButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (context) {
                            return Paymentuploadsheet();
                          });
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      padding: const EdgeInsets.all(10.00),
                    ),
                    child: const Text('Confirm Upload '),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
