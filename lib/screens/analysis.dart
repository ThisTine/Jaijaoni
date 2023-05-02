//Tine
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/analysis/month_conclute.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';

import '../components/analysis/debt_list_people.dart';
import '../providers/analysis/analysis_provider.dart';

class DebtAnalysisScreen extends ConsumerWidget {
  const DebtAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barDataList = ref.watch(analysisProivder);
    return Scaffold(
        appBar:
            customAppBarBuilder(context, text: "Analysis", backButton: true),
        body: Center(
          child: Container(
            constraints: wrapperConstranints,
            child: ListView(
              children: [
                SizedBox(
                  height: 300,
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (AnalysisBarData bardata
                            in barDataList.analysisBarList)
                          MonthConclute(
                              isSelected: bardata.yearMonthLabel ==
                                  barDataList.selectedBar,
                              lentBar: BarValue(
                                  amountLabel: bardata.lentPrice,
                                  barPercentage: (bardata.lentPrice /
                                          barDataList.maxValue) *
                                      100),
                              borrowBar: BarValue(
                                  amountLabel: bardata.borrowPrice,
                                  barPercentage: (bardata.borrowPrice /
                                          barDataList.maxValue) *
                                      100),
                              text: bardata.yearMonthLabel)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DebtListPeople(monthLabel: barDataList.selectedBar),
                ),
              ],
            ),
          ),
        ));
  }
}
