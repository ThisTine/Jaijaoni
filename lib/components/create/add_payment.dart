import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/create/add_box_button.dart';
import 'package:jaijaoni/components/create/payment_bottom_sheet.dart';
import 'package:jaijaoni/components/create/payment_method_box.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

class AddPayment extends ConsumerStatefulWidget {
  const AddPayment({super.key});

  @override
  ConsumerState<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends ConsumerState<AddPayment> {
  late final allInfo = ref.watch(createDebtDataProvider);

  late List<Map<String, String>> paymentList = allInfo.paymentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context, text: "Create", backButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ]),
              addPaymentBox(paymentList, (newPaymentList) {
                allInfo.changePayment(paymentList: newPaymentList);

                setState(() {
                  paymentList = newPaymentList;
                });
              }),
              ...paymentList.map((e) =>
                  PaymentMethodBox(method: e["method"]!, number: e["number"]!)),
              const SizedBox(
                height: 50,
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.secondaryContainer),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: FilledButton(
                        onPressed: paymentList.isEmpty
                            ? null
                            : () {
                                allInfo.clear();
                                context.go("/detail");
                              },
                        child: Text(
                          'Create debt',
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

  Widget addPaymentBox(
      List<Map<String, String>> paymentList, Function handleUpdatePaymentList) {
    return GestureDetector(
      child: const AddBoxButton(title: 'Add Payment', icon: Icons.add),
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return PaymentBottomsheet(
                paymentList: paymentList,
                handlePaymentMethod: handleUpdatePaymentList,
              );
            });
      },
    );
  }
}
