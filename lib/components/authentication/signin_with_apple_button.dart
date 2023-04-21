import 'package:flutter/material.dart';

class SignInWithApple extends StatelessWidget {
  final bool isSignup;
  const SignInWithApple({super.key, this.isSignup = false});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            elevation: 2,
            backgroundColor:
                Theme.of(context).colorScheme.onSecondaryContainer),
        child: Row(
          children: [
            Image.asset(
              "images/authentication/apple.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "${isSignup ? "Register" : "Login"} With Apple",
              style: Theme.of(context).textTheme.titleSmall!.merge(
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
            )
          ],
        ));
  }
}
