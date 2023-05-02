// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayerItemUnpaid extends ConsumerStatefulWidget {
  final void Function(String, double) handleCustomCalculation;
  PayerItemUnpaid(
      {super.key,
      required this.id,
      required this.imagePath,
      required this.name,
      required this.price,
      required this.handleCustomCalculation});
  final String id;
  final String imagePath;
  final String name;
  double price;

  @override
  ConsumerState<PayerItemUnpaid> createState() => _PayerItemUnpaidState();
}

class _PayerItemUnpaidState extends ConsumerState<PayerItemUnpaid> {
  final _formKey = GlobalKey<FormState>();
  // late double price = widget.price;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final price = TextEditingController(text: widget.price.toString());

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      foregroundImage: AssetImage(widget.imagePath),
                    ),
                    // ClipOval(
                    //   child: SizedBox.fromSize(
                    //     size: const Size.fromRadius(50),
                    //     child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.fontSize),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: price,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'))
                              ],
                              decoration: const InputDecoration(
                                labelText: 'Amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          widget.handleCustomCalculation(
                                              widget.id,
                                              double.parse(price.text));
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Update Debt',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              );
            });
      },
      child: Container(
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
                      child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Flexible(
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontSize),
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
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
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
      ),
    );
  }
}
