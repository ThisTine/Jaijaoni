import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';
import 'package:jaijaoni/services/auth/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _isLoading = false;

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void showScaffold(String text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }

    void popToLogin() {
      if (context.canPop()) {
        context.pop();
      } else {
        context.push("/login");
      }
    }

    void resetPassword() async {
      if (_formKey.currentState!.validate() && context.mounted) {
        setLoading(true);
        try {
          await AuthService().forgetPassword(_email.text);
          setLoading(false);
          showScaffold("Please check your email, then try logining in again");
          popToLogin();
        } catch (err) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(err.toString())));
          setLoading(false);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            popToLogin();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                    Text("Reset your password",
                        style: Theme.of(context).textTheme.headlineSmall),
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
                    const SizedBox(
                      height: 30,
                    ),
                    FilledButton(
                      onPressed: resetPassword,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        padding: const EdgeInsets.all(10.00),
                      ),
                      child: Text(_isLoading ? "Loading" : "reset password"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
