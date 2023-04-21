//Phon
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/authentication/signin_with_google_button.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';

import '../components/authentication/signin_divider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authProvider);

    const borderTextField = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(100.00)));

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
                  constraints: wrapperConstranints,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Jai Jaoni",
                          style: Theme.of(context).textTheme.displayMedium),
                      Text("Sign in to your account",
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Username or Email",
                          border: borderTextField,
                          contentPadding: EdgeInsets.all(20.00),
                        ),
                        controller: _email,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _password,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: borderTextField,
                          contentPadding: EdgeInsets.all(20.00),
                        ),
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
                        child: Text(_isLoading ? "Loading" : "Login"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const Text("Forgot password ?")),
                      const SignInDivider(
                        text: "or sign in with",
                      ),
                      const SignInWithGoogleButton()
                    ],
                  ),
                ),
              ),
            )));
  }
}
