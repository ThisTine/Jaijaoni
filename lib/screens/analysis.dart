//Tine
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/analysis/month_conclute.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';

class DebtAnalysisScreen extends StatelessWidget {
  const DebtAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            customAppBarBuilder(context, text: "Analysis", backButton: true),
        body: Center(
          child: Container(
            constraints: wrapperConstranints,
            child: Column(
              children: [
                Container(
                  height: 300,
                  // color: Colors.red,
                  child: Row(
                    children: const [MonthConclute()],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
