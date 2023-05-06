//Tine
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/analysis/month_conclute.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/providers/analysis/subscript_user_provider.dart';

import '../components/analysis/debt_list_people.dart';
import '../providers/analysis/analysis_provider.dart';

class DebtAnalysisScreen extends ConsumerWidget {
  const DebtAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStream = ref.watch(subscriptUserProvider);
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
                    child: userStream.when(
                        data: (data) {
                          double maxV = 0;
                          for (Charts barData in data.charts) {
                            maxV = max(maxV,
                                max(barData.borrowTotal, barData.lendTotal));
                          }
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (Charts bardata in data.charts)
                                  MonthConclute(
                                      isSelected: bardata.monthLabel ==
                                          barDataList.selectedBar,
                                      lentBar: BarValue(
                                          amountLabel: bardata.lendTotal,
                                          barPercentage: (bardata.lendTotal /
                                                  maxV) *
                                              100),
                                      borrowBar: BarValue(
                                          amountLabel: bardata.borrowTotal,
                                          barPercentage: (bardata.borrowTotal /
                                                  maxV) *
                                              100),
                                      text: bardata.monthLabel)
                              ],
                            ),
                          );
                        },
                        error: (error, stackTrace) => Center(child: Text(error.toString())),
                        loading: () => const Center(child: Text("Loading data....")))),
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
