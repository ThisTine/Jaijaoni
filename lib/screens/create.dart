import 'package:flutter/material.dart';
//Muaymi
import 'package:go_router/go_router.dart';

class CreateDebtScreen extends StatelessWidget {
  const CreateDebtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.pop()),
        title: const Text("Create"),
      ),
      body: const Center(
        child: Text("Create Screen"),
      ),
    );
  }
}
