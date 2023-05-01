import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Paymentuploadsheet extends StatelessWidget {
  const Paymentuploadsheet({Key? key, required this.imagefile})
      : super(key: key);
  final File? imagefile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 500,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(19), topRight: Radius.circular(19)),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, bottom: 32, right: 30, left: 32),
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 20),
                      child: imagefile != null
                          ? Image.network(
                              (imagefile!.path),
                              width: double.infinity,
                              height: 400,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.cancel_outlined),
                            // color: Colors.black,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: FilledButton(
                        onPressed: () {
                          return context.go("/detail");
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