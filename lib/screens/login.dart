//Phon
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/services/auth/authService.dart';

import '../providers/authProvider.dart';

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

    return Scaffold(
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                ),
                TextFormField(
                  controller: _password,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setLoading(true);
                        try {
                          await authService.login(_email.text, _password.text);
                          setLoading(false);
                        } catch (err) {
                          setLoading(false);
                        }
                      }
                    },
                    child: Text(_isLoading ? "Loading" : "Login"))
              ],
            )));
  }
}
