//Phon
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/authentication/signin_options.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';
import 'package:jaijaoni/functions/authentication/email_validation.dart';
import '../config/theme/custom_wrapper.dart';
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
  bool _isShowPassword = false;
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

    void login() async {
      if (_formKey.currentState!.validate()) {
        setLoading(true);
        try {
          await authService.login(_email.text, _password.text);
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
                constraints: wrapperConstranints,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text("Jai Jaoni",
                            style: Theme.of(context).textTheme.displayMedium),
                        Text("Login to your account",
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) => value!.isEmpty
                              ? "Email must not be empty."
                              : !validateEmail(value)
                                  ? "Uncorrect email formatted."
                                  : null,
                          decoration:
                              roundInput.copyWith(labelText: "Email address"),
                          controller: _email,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: !_isShowPassword,
                          validator: (value) => value!.isEmpty
                              ? "Password must not be empty."
                              : null,
                          controller: _password,
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
                            onPressed: () {
                              context.push("/reset-password");
                            },
                            child: const Text("Forgot password ?")),
                        const SignInOptions(),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ?"),
                        TextButton(
                            onPressed: () {
                              context.go("/register");
                            },
                            child: const Text("Register"))
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
