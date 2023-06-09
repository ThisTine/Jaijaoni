import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';
import 'package:jaijaoni/functions/utils/remove_payment_channel_from_user.dart';

class PaymentOption {
  final String channel;
  final String number;
  final bool isCheck;
  PaymentOption(
      {required this.channel, required this.number, this.isCheck = false});
}

class CreateDebtData extends ChangeNotifier {
  String name = "";
  DateTime? dueDate;
  double totalPrice = 0;
  List<SelectedFirend> friendList = [];
  List<PaymentOption> paymentList = [];
  void changeDeptInfo(
      {required String name,
      required DateTime dueDate,
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

  void changePayment({required List<PaymentOption> paymentList}) {
    // List<String> existingPayment = this.paymentList.map((e) => e.channel+e.number).toList();
    // print(existingPayment);
    this.paymentList = paymentList;
    notifyListeners();
  }

  void addPayment({required List<PaymentOption> paymentList}) {
    // print("adding debt");
    List<String> existingPayment =
        this.paymentList.map((e) => e.channel + e.number).toList();
    this.paymentList = [
      ...this.paymentList,
      ...paymentList
          .where((element) =>
              !existingPayment.contains(element.channel + element.number))
          .toList()
    ];

    // var updatedpaymentOption = this
    //     .paymentList
    //     .where((element) => !paymentList
    //         .where((element2) =>
    //             element.channel == element2.channel &&
    //             element.number == element2.number)
    //         .toList()
    //         .isNotEmpty)
    //     .toList();
    // for (var payment in paymentList) {
    //   updatedpaymentOption
    //       .add(PaymentOption(channel: payment.channel, number: payment.number));
    // }
    // this.paymentList = updatedpaymentOption;
    notifyListeners();
    // updatedpaymentOption.add(PaymentOption(channel: channel, number: number))
  }

  void switchSelectPayment(PaymentOption paymentoption) {
    bool isPromptpay = paymentoption.channel == "PromptPay";
    bool isCheck = !paymentoption.isCheck;
    List<PaymentOption> updatedPaymentList = paymentList
        .map((e) => e.channel == paymentoption.channel &&
                e.number == paymentoption.number
            ? PaymentOption(
                channel: e.channel, number: e.number, isCheck: !e.isCheck)
            : ((e.channel == "PromptPay" && isPromptpay) ||
                        (e.channel != "PromptPay" && !isPromptpay)) &&
                    isCheck
                ? PaymentOption(
                    channel: e.channel, number: e.number, isCheck: false)
                : e)
        .toList();
    paymentList = updatedPaymentList;
    notifyListeners();
  }

  Future<void> deletePaymentMethod(PaymentOption paymentOption) async {
    try {
      paymentList = paymentList
          .where((e) => !(e.channel == paymentOption.channel &&
              e.number == paymentOption.number))
          .toList();
      removePaymentChannelFromUser(paymentOption);
    } catch (err) {
      rethrow;
    }
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
                id: e.id,
                imagePath: e.imagePath,
                name: e.name,
                price: double.parse(
                    (remainingPrice / peopleWithNoCustom).toStringAsFixed(2)),
                username: e.username,
              ))
        .toList();

    friendList = calculatedPeopleList;
  }

  void clear() {
    name = "";
    dueDate = null;
    totalPrice = 0;
    friendList = [];
    paymentList = [];
  }
}

final createDebtDataProvider =
    ChangeNotifierProvider((ref) => CreateDebtData());
