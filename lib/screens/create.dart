// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/config/theme/custom_wrapper.dart';
//Muaymi

import '../components/custom_app_bar.dart';
import '../components/create/debt_form.dart';

class CreateDebtScreen extends ConsumerStatefulWidget {
  const CreateDebtScreen({super.key});

  @override
  ConsumerState<CreateDebtScreen> createState() => _CreateDebtScreenState();
}

class _CreateDebtScreenState extends ConsumerState<CreateDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:
              customAppBarBuilder(context, text: "Create", backButton: true),
          body: Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      constraints: wrapperConstranints,
                      child: Row(
                        children: [
                          const SizedBox(width: 16.0),
                          Text(
                            'Debt Info',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.fontSize),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: DebtForm()),
                ],
              ),
            ],
          )),
    );
  }
}
