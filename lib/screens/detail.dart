//Phon
import 'package:flutter/material.dart';
import 'package:jaijaoni/screens/detail_creator.dart';

class DebtDetailScreen extends StatelessWidget {
  final String debtId;
  const DebtDetailScreen({super.key,required this.debtId});

  @override
  Widget build(BuildContext context) {
    return const DetailCreator();
  }
}
