import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';

import '../../screens/create.dart';

class DebtForm extends StatefulWidget {
  const DebtForm({super.key});

  @override
  State<DebtForm> createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _dueDate = TextEditingController();
  final _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _name,
                          decoration: roundInput.copyWith(labelText: 'Name'),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        TextFormField(
                            controller: _dueDate,
                            decoration:
                                roundInput.copyWith(labelText: 'Due date')),
                        const SizedBox(
                          height: 23,
                        ),
                        TextFormField(
                            controller: _price,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                roundInput.copyWith(labelText: 'Total price'))
                      ],
                    )),
                const SizedBox(height: 150),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Expanded(
                          child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).colorScheme.primary),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPeople(
                                              price: _price.text,
                                            )));
                              },
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                              )),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
