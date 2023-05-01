import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/create/friend_bottom_sheet.dart';
import 'package:jaijaoni/components/create/payer_item_unpaid.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';

import '../custom_app_bar.dart';
import 'add_box_button.dart';
import 'add_payment.dart';

class AddPeople extends ConsumerStatefulWidget {
  const AddPeople({super.key, required this.price});
  final String price;

  @override
  ConsumerState<AddPeople> createState() => _AddPeopleState();
}

class _AddPeopleState extends ConsumerState<AddPeople> {
  final _buttomkey = GlobalKey<ScaffoldState>();
  List<SelectedFirend> peopleList = [];
  late double price;

  @override
  void initState() {
    super.initState();
    price = double.parse(widget.price);
  }

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
                                id: e.id,
                                imagePath: "images/profile/dazai.jpg",
                                name: e.name,
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
      List<SelectedFirend> peopleList, Function handleUpdatePeopleList) {
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
