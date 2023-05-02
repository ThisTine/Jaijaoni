//Tine
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/authentication/signin_options.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';

import '../functions/authentication/email_validation.dart';
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
  final _confirmPassword = TextEditingController();
  bool _isLoading = false;
  bool _isShowPassword = false;

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
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authProvider);

    void signup() async {
      if (_formKey.currentState!.validate()) {
        setLoading(true);
        try {
          await authService.signup(_username.text, _email.text, _password.text);
          setLoading(false);
        } catch (err) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(err.toString())));
          setLoading(false);
        }
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 576),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          validator: (value) => value!.isEmpty
                              ? "Username must not empty."
                              : null,
                          decoration:
                              roundInput.copyWith(labelText: "Username"),
                          controller: _username,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Email must not be empty."
                              : !validateEmail(value)
                                  ? "Uncorrect email formatted."
                                  : null,
                          decoration: roundInput.copyWith(labelText: "Email"),
                          controller: _email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _password,
                          obscureText: !_isShowPassword,
                          validator: (value) => value!.isEmpty
                              ? "Password must not be empty."
                              : value != _confirmPassword.text
                                  ? "Passwords are not the same"
                                  : null,
                          decoration: roundInput.copyWith(
                              labelText: "Password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isShowPassword = !_isShowPassword;
                                      });
                                    },
                                    icon: Icon(_isShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _confirmPassword,
                          obscureText: !_isShowPassword,
                          validator: (value) => value!.isEmpty
                              ? "Password must not be empty."
                              : value != _password.text
                                  ? "Passwords are not the same"
                                  : null,
                          decoration: roundInput.copyWith(
                              labelText: "Confirm Password",
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isShowPassword = !_isShowPassword;
                                      });
                                    },
                                    icon: Icon(_isShowPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FilledButton(
                          onPressed: signup,
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
                      ],
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
          )),
    ));
  }
}
