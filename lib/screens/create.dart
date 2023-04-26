import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/payer_item_unpaid.dart';
//Muaymi

import '../components/custom_app_bar.dart';
import '../components/debt_form.dart';

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
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
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
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
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
                    const SizedBox(
                      width: 13,
                    ),
                  ],
                ))
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _buttomkey,
      appBar: customAppBarBuilder(context, text: "Create", backButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              const SizedBox(
                width: 13,
              ),
              Text(
                'Who will be sharing?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                ),
                textAlign: TextAlign.start,
              ),
            ]),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  AddPeopleBox(),
                  const PayerItemUnpaid(),
                  const SizedBox(
                    height: 13,
                  ),
                  const PayerItemUnpaid(),
                  const SizedBox(
                    height: 13,
                  ),
                  const PayerItemUnpaid(),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      FilledButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(horizontal: 55))),
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
                      const SizedBox(
                        width: 20,
                      ),
                      FilledButton(
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
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AddPeopleBox() {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListView(children: [
                  Container(
                    padding: const EdgeInsets.all(20),
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
                        const FriendList(),
                      ],
                    ),
                  ),
                  FilledButton(
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
                ]);
              });
        },
        child: Container(
          width: 358,
          height: 82,
          margin: const EdgeInsets.only(bottom: 13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.secondaryContainer,
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add),
              const SizedBox(
                width: 6,
              ),
              Text(
                'Add People',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize:
                        Theme.of(context).textTheme.titleMedium!.fontSize),
              )
            ],
          ),
        ));
  }
}

class FriendList extends StatelessWidget {
  const FriendList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 30,
      itemBuilder: ((context, index) {
        return Column(children: [
          ListTile(
            title: Row(
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(20),
                    child: Image.network("images/profile/dazai.jpg",
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Text('Muaymi'),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
