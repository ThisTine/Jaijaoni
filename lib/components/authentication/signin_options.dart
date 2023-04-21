import 'package:flutter/material.dart';
import 'package:jaijaoni/components/authentication/signin_divider.dart';
import 'package:jaijaoni/components/authentication/signin_with_apple_button.dart';
import 'package:jaijaoni/components/authentication/signin_with_google_button.dart';

class SignInOptions extends StatelessWidget {
  final bool isSignup;
  const SignInOptions({super.key, this.isSignup = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInDivider(
          text: "or ${isSignup ? "register" : "login"} with",
        ),
        SignInWithGoogleButton(isSignup: isSignup),
        const SizedBox(
          height: 10,
        ),
        SignInWithApple(
          isSignup: isSignup,
        ),
      ],
    );
  }
}
