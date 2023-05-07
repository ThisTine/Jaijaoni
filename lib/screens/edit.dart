import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/create/add_box_button.dart';
import 'package:jaijaoni/components/create/payment_bottom_sheet.dart';
import 'package:jaijaoni/components/create/payment_method_box.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';
import 'package:jaijaoni/functions/create/create_debt.dart';
import 'package:jaijaoni/functions/create/get_payment_options.dart';
import 'package:jaijaoni/functions/edit/edit_payment_channel.dart';
import 'package:jaijaoni/functions/edit/get_debt_by_debt_id.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/functions/utils/loading_dialog.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

class EditDebtScreen extends ConsumerStatefulWidget {
  final String debtId;
  const EditDebtScreen({super.key, this.debtId = ""});

  @override
  ConsumerState<EditDebtScreen> createState() => _EditDebtScreenState();
}

class _EditDebtScreenState extends ConsumerState<EditDebtScreen> {
  late final allInfo = ref.watch(createDebtDataProvider);

  Debts? debt;

  void editPaymentHandeler() {
    showLoadingDialog(context, "Updating Debt");
    editPaymentChannels(
            allInfo.paymentList.where((element) => element.isCheck).toList(),
            widget.debtId)
        .then((value) {
      allInfo.clear();
      context.pop();
      context.go("/detail/${widget.debtId}");
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  void initData() {
    // showLoadingDialog(context, "Creating Debt");
    getDebtById(widget.debtId).then((value) {
      // context.pop();
      allInfo.clear();
      allInfo.changePayment(
          paymentList: value.payChannels
              .map((e) => PaymentOption(
                  channel: e.channel, number: e.number, isCheck: true))
              .toList());
      setState(() {});
      findUserById(FirebaseAuth.instance.currentUser!.uid).then((value) {
        allInfo.addPayment(
            paymentList: value.accs
                .map((e) => PaymentOption(channel: e.accName, number: e.accNo))
                .toList());
        setState(() {});
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
    // getPaymentOption().then((value) => allInfo.addPayment(paymentList: value));
  }

  // late List<PaymentOption> paymentList = allInfo.paymentList;

  @override
  Widget build(BuildContext context) {
    // print(allInfo.paymentList.map((e) => e.isCheck));
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Edit", backButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: wrapperConstranints,
                child: Column(children: [
                  Row(children: [
                    const SizedBox(
                      width: 13,
                    ),
                    Flexible(
                      child: Text(
                        'How do they pay?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ]),
                  addPaymentBox(allInfo.paymentList,
                      (List<PaymentOption> newPaymentList) {
                    allInfo.changePayment(paymentList: newPaymentList);
                    setState(() {});
                  }),
                  ...allInfo.paymentList.map((e) {
                    // print(e.isCheck);
                    return Dismissible(
                      onDismissed: (direction) {
                        allInfo.deletePaymentMethod(e);
                        setState(() {});
                      },
                      key: Key(e.channel + e.number),
                      child: PaymentMethodBox(
                        isCheck: e.isCheck,
                        method: e.channel,
                        number: e.number,
                        switchIsCheck: () {
                          allInfo.switchSelectPayment(e);
                          setState(() {});
                        },
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 50,
                  )
                ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FilledButton(
                        onPressed: allInfo.paymentList
                                .where((element) => element.isCheck)
                                .isEmpty
                            ? null
                            : () {
                                editPaymentHandeler();
                              },
                        child: Text(
                          'Edit debt',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addPaymentBox(List<PaymentOption> paymentList,
      Function(List<PaymentOption>) handleUpdatePaymentList) {
    return Container(
      width: 358,
      height: 82,
      margin: const EdgeInsets.all(10),
      child: Material(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: const AddBoxButton(title: 'Add Payment', icon: Icons.add),
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return PaymentBottomsheet(
                    paymentList: paymentList,
                    handlePaymentMethod: handleUpdatePaymentList,
                  );
                });
          },
        ),
      ),
    );
  }
}
