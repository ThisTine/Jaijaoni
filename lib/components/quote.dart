import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/profile/user_name.dart';

Widget quote(BuildContext context,
    {required double height, String? customQuote}) {
  return Row(
    children: [
      Expanded(
        child: Container(
          constraints: BoxConstraints(maxWidth: 326, minHeight: height),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: customQuote != null
                      ? Text(customQuote,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .fontSize))
                      : FutureBuilder<String>(
                          future: quoteprefill(),
                          builder: (context, snapshot) {
                            return Text(
                              !(snapshot.data == null || snapshot.data == "")
                                  ? snapshot.data ?? ""
                                  : "Type your quote here",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .fontSize),
                            );
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
