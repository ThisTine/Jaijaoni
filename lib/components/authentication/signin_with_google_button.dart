import 'package:flutter/material.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            elevation: 2,
            backgroundColor: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            Image.asset(
              "images/authentication/google.png",
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              "Sign In With Google",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(TextStyle(color: Theme.of(context).colorScheme.scrim)),
            )
          ],
        ));
  }
}
