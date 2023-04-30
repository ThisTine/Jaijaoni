import 'dart:html';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/circle_avata.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Edit", backButton: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            circleAvata(radius: 70),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Upload Profile",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleSmall!.fontSize)),
                IconButton(
                    onPressed: () {
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) => Padding(
                      //         padding: const EdgeInsets.all(20.0),
                      //         child: ListView(children: [Row(children: [])])));
                    },
                    icon: Icon(Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                        size: Theme.of(context).textTheme.titleSmall!.fontSize))
              ],
            ),
            const SizedBox(height: 20),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textlebel(context, "Name"),
                      const SizedBox(width: 65),
                      hintlebel(context, "Default Name"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textlebel(context, "Quote"),
                      const SizedBox(width: 65),
                      hintlebel(context, "add quote"),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textlebel(context, "Password"),
                      const SizedBox(width: 45),
                      hintlebel(context, "current password"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 115),
                      hintlebel(context, "new password"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 115),
                      hintlebel(context, "confirm password"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget textlebel(BuildContext context, String text) {
  return Text(text,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize));
}

Widget hintlebel(BuildContext context, String text) {
  return (SizedBox(
      width: 220,
      height: 50,
      child: TextField(
        cursorColor: Theme.of(context).colorScheme.primaryContainer,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primaryContainer,
              fontSize: Theme.of(context).textTheme.labelMedium!.fontSize),
        ),
      )));
}
