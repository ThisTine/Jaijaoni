import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Paymentuploadsheet extends StatefulWidget {
  Paymentuploadsheet({Key? key, required this.imagefile}) : super(key: key);
  final File? imagefile;

  @override
  State<Paymentuploadsheet> createState() => _PaymentuploadsheetState();
}

class _PaymentuploadsheetState extends State<Paymentuploadsheet> {
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
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: widget.imagefile != null
                    ? Image.file(File(widget.imagefile.path)
                        widget.imagefile!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/images/product-placeholder.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: FilledButton(
                        onPressed: () {
                          return context.go("/payment");
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
