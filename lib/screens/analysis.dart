//Tine
import 'package:flutter/material.dart';

class DebtAnalysisScreen extends StatelessWidget {
  const DebtAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis"),
      ),
      body: const Center(
        child: Text("Debt Analysis"),
      ),
    );
  }
}
