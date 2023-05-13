import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/auth_provider.dart';
import '../../services/auth/auth_service.dart';

class SignInWithGoogleButton extends ConsumerWidget {
  final bool isSignup;
  const SignInWithGoogleButton({super.key, this.isSignup = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.read(authProvider);
    return FilledButton(
        onPressed: () {
          kIsWeb ? authService.googleLoginWeb() : authService.googleLogin();
        },
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
              "${isSignup ? "Register" : "Login"} With Google",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .merge(TextStyle(color: Theme.of(context).colorScheme.scrim)),
            )
          ],
        ));
  }
}
