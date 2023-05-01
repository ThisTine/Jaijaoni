import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';

class CreateDebtData extends ChangeNotifier {
  String name = "";
  String dueDate = "";
  double totalPrice = 0;
  List<SelectedFirend> friendList = [];
  List<Map<String, String>> paymentList = [];
  void changeDeptInfo(
      {required String name,
      required String dueDate,
      required double totalPrice}) {
    this.name = name;
    this.dueDate = dueDate;
    this.totalPrice = totalPrice;
    _reCalculatePrice();
    notifyListeners();
  }

  void changePeople({required List<SelectedFirend> friendList}) {
    this.friendList = friendList;
    notifyListeners();
  }

  void changePayment({required List<Map<String, String>> paymentList}) {
    this.paymentList = paymentList;
    notifyListeners();
  }

  void _reCalculatePrice() {
    int peopleWithNoCustom = 0;
    double remainingPrice = totalPrice;
    for (SelectedFirend friend in friendList) {
      if (!friend.isCustomed) {
        peopleWithNoCustom++;
      } else {
        remainingPrice -= friend.price;
      }
    }
    List<SelectedFirend> calculatedPeopleList = friendList
        .map((e) => e.isCustomed
            ? e
            : SelectedFirend(
                e.id,
                e.imagePath,
                e.name,
                double.parse(
                    (remainingPrice / peopleWithNoCustom).toStringAsFixed(2))))
        .toList();

    friendList = calculatedPeopleList;
  }

  void clear() {
    name = "";
    dueDate = "";
    totalPrice = 0;
    friendList = [];
    paymentList = [];
  }
}

final createDebtDataProvider =
    ChangeNotifierProvider((ref) => CreateDebtData());
