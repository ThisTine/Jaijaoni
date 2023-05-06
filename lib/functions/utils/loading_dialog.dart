import 'package:flutter/material.dart';

void showLoadingDialog (BuildContext context, String? text){
  showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                 const CircularProgressIndicator(),
                 const SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text(text??"loading...")
                ],
              ),
            ),
          );
        });
}