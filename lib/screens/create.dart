import 'package:flutter/material.dart';
//Muaymi

import '../components/custom_app_bar.dart';

class CreateDebtScreen extends StatelessWidget {
  const CreateDebtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Create", backButton: true),
      body: const Center(
        child: Text("Create Screen"),
      ),
    );
  }
}
