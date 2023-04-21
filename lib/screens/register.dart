//Tine
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/authentication/signin_options.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';

import '../components/authentication/signin_divider.dart';
import '../components/authentication/signin_with_apple_button.dart';
import '../components/authentication/signin_with_google_button.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authProvider);

    void login() async {
      if (_formKey.currentState!.validate()) {
        setLoading(true);
        try {
          await authService.login(_email.text, _password.text);
          setLoading(false);
        } catch (err) {
          setLoading(false);
        }
      }
    }

    return Scaffold(
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 576),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Jai Jaoni",
                          style: Theme.of(context).textTheme.displayMedium),
                      Text("Register your account",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: roundInput.copyWith(labelText: "Username"),
                        controller: _username,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: roundInput.copyWith(labelText: "Email"),
                        controller: _email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _password,
                        decoration: roundInput.copyWith(labelText: "Password"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FilledButton(
                        onPressed: login,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.all(10.00),
                        ),
                        child: Text(_isLoading ? "Loading" : "Register"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SignInOptions(
                        isSignup: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ?"),
                          TextButton(
                              onPressed: () {
                                context.go("/login");
                              },
                              child: const Text("Login"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
