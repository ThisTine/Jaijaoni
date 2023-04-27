import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnalysisBarData {
  final double lentPrice;
  final double borrowPrice;
  final String yearMonthLabel;
  AnalysisBarData(
      {required this.lentPrice,
      required this.borrowPrice,
      required this.yearMonthLabel});
}

class AnalysisData extends ChangeNotifier {
  List<AnalysisBarData> analysisBarList = [
    AnalysisBarData(
        lentPrice: 300, borrowPrice: 100, yearMonthLabel: "Jan,2023"),
    AnalysisBarData(
        lentPrice: 70, borrowPrice: 1000, yearMonthLabel: "Feb,2023"),
    AnalysisBarData(
        lentPrice: 300, borrowPrice: 380, yearMonthLabel: "March,2023"),
    AnalysisBarData(
        lentPrice: 500, borrowPrice: 10, yearMonthLabel: "April,2023")
  ];
  bool isBarLoading = false;
  String selectedBar = 'April,2023';
  AnalysisData();

  void setSelectedBar(String yearMonthLabel) {
    selectedBar = yearMonthLabel;
    notifyListeners();
  }

  double get maxValue {
    double maxV = 0;
    for (AnalysisBarData barData in analysisBarList) {
      maxV = max(maxV, max(barData.borrowPrice, barData.lentPrice));
    }
    return maxV;
  }
}

final analysisProivder = StateProvider((ref) => AnalysisData());
