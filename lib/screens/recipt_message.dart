import 'package:flutter/material.dart';
import 'package:jaijaoni/screens/profile.dart';
import 'package:jaijaoni/screens/recipt_message.dart';

class ReciptMessage extends StatelessWidget {
  const ReciptMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvata(),
                const SizedBox(height: 15),
                Text(
                  "Name" + "'s",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),
                const SizedBox(height: 21),
                Receipt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget Receipt(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 164,
          constraints: const BoxConstraints(maxWidth: 326),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 1), // changes position of shadow
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
                  child: Text(
                    "info",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
