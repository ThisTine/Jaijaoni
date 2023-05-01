import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/create/friend_bottom_sheet.dart';
import 'package:jaijaoni/components/create/payer_item_unpaid.dart';
import 'package:jaijaoni/components/create/selected_friend.dart';
import 'package:jaijaoni/providers/create/create_debt_data_provider.dart';

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
  late final allInfo = ref.watch(createDebtDataProvider);
  final _buttomkey = GlobalKey<ScaffoldState>();
  late List<SelectedFirend> peopleList = allInfo.friendList;
  late double price;

  @override
  void initState() {
    super.initState();
    price = double.parse(widget.price);
  }

  void handleCustomCalculation(String id, double price) {
    List<SelectedFirend> calculatedPeopleList = peopleList
        .map((e) => e.id == id
            ? SelectedFirend(
                id, e.imagePath, e.name, double.parse(price.toStringAsFixed(2)),
                isCustomed: true)
            : e)
        .toList();
    setState(() {
      peopleList = calculatedPeopleList;
    });
    reCalculatePrice();
  }

  void reCalculatePrice() {
    int peopleWithNoCustom = 0;
    double remainingPrice = price;
    for (SelectedFirend friend in peopleList) {
      if (!friend.isCustomed) {
        peopleWithNoCustom++;
      } else {
        remainingPrice -= friend.price;
      }
    }
    List<SelectedFirend> calculatedPeopleList = peopleList
        .map((e) => e.isCustomed
            ? e
            : SelectedFirend(
                e.id,
                e.imagePath,
                e.name,
                double.parse(
                    (remainingPrice / peopleWithNoCustom).toStringAsFixed(2))))
        .toList();

    setState(() {
      peopleList = calculatedPeopleList;
    });
    allInfo.changePeople(friendList: calculatedPeopleList);
  }

  void handleOnAddPerson(newPeopleList) {
    setState(() {
      peopleList = newPeopleList;
    });
    reCalculatePrice();
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
                      addPeopleBox(peopleList, handleOnAddPerson),
                      for (SelectedFirend friend in peopleList)
                        PayerItemUnpaid(
                            handleCustomCalculation: handleCustomCalculation,
                            id: friend.id,
                            imagePath: "images/profile/dazai.jpg",
                            name: friend.name,
                            price: friend.price),
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
                        onPressed: peopleList.isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddPayment()));
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
