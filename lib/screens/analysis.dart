//Tine
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/analysis/month_conclute.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';

import '../components/analysis/debt_list_people.dart';

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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 50),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 70),
                          text: "Jan",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 30),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 30),
                          text: "Feb",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 50),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 70),
                          text: "Jan",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 50),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 70),
                          text: "Jan",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 50),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 70),
                          text: "Jan",
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MonthConclute(
                          borrowBar:
                              BarValue(amountLabel: 20, barPercentage: 50),
                          rentBar: BarValue(amountLabel: 20, barPercentage: 70),
                          text: "Jan",
                          isSelected: true,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                DebtListPeople(),
              ],
            ),
          ),
        ));
  }
}
