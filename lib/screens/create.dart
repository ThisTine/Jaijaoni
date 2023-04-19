import 'package:flutter/material.dart';
//Muaymi
import 'package:go_router/go_router.dart';

import '../components/CustomAppBar.dart';

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
