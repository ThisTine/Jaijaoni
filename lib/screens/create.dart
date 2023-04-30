import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/add_box_button.dart';
import 'package:jaijaoni/components/payer_item_unpaid.dart';
import 'package:jaijaoni/components/payment_method_box.dart';
//Muaymi

import '../components/custom_app_bar.dart';
import '../components/debt_form.dart';
import '../components/friend_list_check.dart';

class CreateDebtScreen extends ConsumerStatefulWidget {
  const CreateDebtScreen({super.key});

  @override
  ConsumerState<CreateDebtScreen> createState() => _CreateDebtScreenState();
}

class _CreateDebtScreenState extends ConsumerState<CreateDebtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarBuilder(context, text: "Create", backButton: true),
        body: Stack(
          children: [
            Column(
              children: [
                Row(
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
                const DebtForm(),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: FilledButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).colorScheme.primary),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(horizontal: 55))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddPeople()));
                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
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
        ));
  }
}

class AddPeople extends ConsumerStatefulWidget {
  const AddPeople({super.key});

  @override
  ConsumerState<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends ConsumerState<AddPeople> {
  final _buttomkey = GlobalKey<ScaffoldState>();
  List<Map<String, String>> peopleList = [];
  double price = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _buttomkey,
      appBar: customAppBarBuilder(context, text: "Create", backButton: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(children: [
                  const SizedBox(
                    width: 13,
                  ),
                  Flexible(
                    child: Text(
                      'Who will be sharing?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  )
                ]),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      addPeopleBox(peopleList, (newPeopleList) {
                        setState(() {
                          peopleList = newPeopleList;
                        });
                      }),
                      ...peopleList
                          .map((e) => PayerItemUnpaid(
                                id: e["id"]!,
                                name: e["name"]!,
                                price: price / peopleList.length,
                              ))
                          .toList(),
                      const SizedBox(height: 50),
                    ],
                  ),
                )
              ],
            ),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPayment()));
                        },
                        child: Text(
                          'Next',
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

  Widget addPeopleBox(
      List<Map<String, String>> peopleList, Function handleUpdatePeopleList) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return FriendBottomsheet(
                    peopleList: peopleList,
                    handleSelectFriend: handleUpdatePeopleList);
              });
        },
        child: const AddBoxButton(
          title: 'Add People',
          icon: Icons.add,
        ));
  }
}

class FriendBottomsheet extends StatefulWidget {
  const FriendBottomsheet(
      {super.key, required this.handleSelectFriend, required this.peopleList});
  final Function handleSelectFriend;
  final List<Map<String, String>> peopleList;

  @override
  State<FriendBottomsheet> createState() => _FriendBottomsheetState();
}

class _FriendBottomsheetState extends State<FriendBottomsheet> {
  List<Map<String, String>> newPeopleList = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      newPeopleList = widget.peopleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height / 2 - 72,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                    child: TextFormField(
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.search),
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                )),
              ),
              Expanded(
                child: FriendList(
                    peopleList: newPeopleList,
                    handleSelectPeople: (newValue) {
                      setState(() {
                        newPeopleList = newValue;
                      });
                    }),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Row(
            children: [
              Expanded(
                child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      widget.handleSelectFriend(newPeopleList);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add (${newPeopleList.length}) People',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class FriendList extends StatefulWidget {
  const FriendList(
      {super.key, required this.peopleList, required this.handleSelectPeople});
  final List<Map<String, String>> peopleList;
  final Function handleSelectPeople;

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  List<Map<String, String>> friendList = [
    {"id": "001", "name": "muaymi"},
    {"id": "002", "name": "tine"},
    {"id": "003", "name": "ri"},
    {"id": "004", "name": "fah"},
    {"id": "005", "name": "fah"},
    {"id": "006", "name": "fah"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
          children: friendList
              .map((e) => ListOfFriend(
                  id: e["id"]!,
                  name: e["name"]!,
                  check: widget.peopleList
                          .indexWhere((element) => element["id"] == e["id"]) !=
                      -1,
                  handleCheck: (check) {
                    if (check) {
                      widget.handleSelectPeople([...widget.peopleList, e]);
                    } else {
                      widget.handleSelectPeople(widget.peopleList
                          .where((element) => element["id"] != e["id"])
                          .toList());
                    }
                  }))
              .toList()),
    );
  }
}

class AddPayment extends StatefulWidget {
  const AddPayment({super.key});

  @override
  State<AddPayment> createState() => _AddPaymentState();
}

class _AddPaymentState extends State<AddPayment> {
  List<Map<String, String>> paymentList = [];

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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPayment()));
                        },
                        child: Text(
                          'Save',
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

class PaymentBottomsheet extends StatefulWidget {
  const PaymentBottomsheet(
      {super.key,
      required this.handlePaymentMethod,
      required this.paymentList});
  final Function handlePaymentMethod;
  final List<Map<String, String>> paymentList;

  @override
  State<PaymentBottomsheet> createState() => _PaymentBottomsheetState();
}

class _PaymentBottomsheetState extends State<PaymentBottomsheet> {
  final _paymentFormKey = GlobalKey<FormState>();
  final _paymentNumber = TextEditingController();
  final items = ["KBank", "SCB", "PromptPay"];
  String selectedValue = "PromptPay";
  late final List<Map<String, String>> newPayment;
  late final Map<String, String> newValue;

  @override
  void initState() {
    super.initState();
    newPayment = widget.paymentList;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _paymentFormKey,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      'Payment Option',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .fontSize),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownButton<String>(
                          iconEnabledColor:
                              Theme.of(context).colorScheme.primary,
                          value: selectedValue,
                          items: items
                              .map<DropdownMenuItem<String>>((String value) =>
                                  DropdownMenuItem<String>(
                                      value: value, child: Text(value)))
                              .toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _paymentNumber,
                decoration: const InputDecoration(
                  labelText: 'Payment Number',
                  border: OutlineInputBorder(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () {
                            setState(() {
                              newValue = {
                                "method": selectedValue,
                                "number": _paymentNumber.text
                              };
                            });
                            widget
                                .handlePaymentMethod([...newPayment, newValue]);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Add Payment',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
