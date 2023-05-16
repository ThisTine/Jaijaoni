import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/friends/addfriend_alert_dialog.dart';
import 'package:jaijaoni/components/quote.dart';
import 'package:jaijaoni/functions/friends/find_transaction_from_friend_id.dart';
import 'package:jaijaoni/functions/profile/analaysis_friend_profile.dart';
import 'package:jaijaoni/functions/profile/find_friend_profile.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/screens/profile.dart';
import 'package:jaijaoni/components/circle_avata.dart';

import '../components/friends/unfriend_alert_dialog.dart';

class FriendProfile extends StatelessWidget {
  final String fid;
  const FriendProfile({super.key, required this.fid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarBuilder(context,
          text: "Friend profile", backButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        child: cardProfile(context, userId: fid),
                      ),
                      Positioned(
                        top: -90,
                        child: FutureBuilder(
                            future: picFrined(fid),
                            builder: (context, snapshot) {
                              return circleAvataUser(
                                  radius: 80, imgUrl: snapshot.data.toString());
                            }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                FutureBuilder(
                    future: findUserById(fid),
                    builder: (context, usersnapshot) {
                      return FutureBuilder(
                          future: findFriendProfile(
                              usersnapshot.data?.username ?? ''),
                          builder: (context, username) {
                            return username.data == true
                                ? FutureBuilder(
                                    future: analaysisFriendProfile(
                                        usersnapshot.data?.userId ?? ''),
                                    builder: (context, snapshot) {
                                      return debtAnalysisBox(
                                          context,
                                          snapshot.data?.paid.toString() ??
                                              '0.0',
                                          snapshot.data?.unpaid.toString() ??
                                              '0.0');
                                    })
                                : Container();
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardProfile(BuildContext context,
    {bool read = false, profileFriend, required String userId}) {
  return (Container(
    width: 350,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: Theme.of(context).colorScheme.secondaryContainer),
    child: FutureBuilder(
      future: findUserById(userId),
      builder: (context, snapshot) => Column(
        children: [
          const SizedBox(height: 100),
          Text("${snapshot.data?.name}",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize:
                      Theme.of(context).textTheme.headlineSmall!.fontSize)),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: quote(context,
                height: 150,
                customQuote: !(snapshot.data?.quote == null ||
                        snapshot.data?.quote == "")
                    ? snapshot.data?.quote ?? ""
                    : "Quote"),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                      read
                          ? Icons.mark_email_read_outlined
                          : Icons.mark_email_unread_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FutureBuilder(
                            future: findTransactionFromFriendId(userId),
                            builder: (ctx, transacSnapshot) {
                              return ListView(
                                children: [
                                  Row(
                                    children: [
                                      FutureBuilder(
                                          future:
                                              picFrined(snapshot.data?.userId),
                                          builder: (ctx, snapshot) {
                                            return circleAvataUser(
                                                radius: 30,
                                                imgUrl:
                                                    snapshot.data.toString());
                                          }),
                                      const SizedBox(width: 24),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data?.name}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .fontSize),
                                          ),
                                          Text(
                                            "@${snapshot.data?.username}",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .fontSize),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 41),
                                    ],
                                  ),
                                  const SizedBox(height: 27),
                                  ...(transacSnapshot.data ?? []).map(
                                    (e) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: PayerCard(
                                          isOpen: true,
                                          reason: e.transac.errMessage,
                                          dId: e.debtId,
                                          tId: e.transac.transactionId,
                                          name: e.transac.username,
                                          amount: e.transac.amount,
                                          circleColorState:
                                              e.transac.isApproved,
                                          // reason: e.transac.,
                                          // done: true, circleColorState: e.borrowId,
                                        ),
                                      );
                                    },
                                  ).toList()
                                ],
                              );
                            }),
                      ),
                    );
                  },
                ),
                snapshot.data == null
                    ? const CircularProgressIndicator()
                    : FriendButton(username: snapshot.data?.username ?? ''),
                IconButton(
                  icon: Icon(Icons.ios_share_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    //share to other
                    Clipboard.setData(
                            ClipboardData(text: "@${snapshot.data?.username}"))
                        .then((value) {
                      const snackBar = SnackBar(
                        content: Text("Copied to clipboard"),
                        duration: Duration(seconds: 1),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ));
}

class FriendButton extends StatefulWidget {
  final String username;
  const FriendButton({
    super.key,
    required this.username,
  });

  @override
  State<FriendButton> createState() => _FriendButtonState();
}

class _FriendButtonState extends State<FriendButton> {
  void unfriend(String username) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => unfriendAlert(context, username),
    );
    setState(() {});
  }

  void addFriend(String username) async {
    await showDialog<bool>(
      context: context,
      builder: (context) => addfriendAlert(context, username),
    );

    setState(() {});

    // ADD FRIEND LOGIC
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: findFriendProfile(widget.username),
        builder: (context, isFsnapshot) {
          // print(isFsnapshot.data);
          if (isFsnapshot.hasError) {
            return Text(isFsnapshot.error.toString());
          }
          if (!isFsnapshot.hasData) {
            return const CircularProgressIndicator();
          }
          return OutlinedButton(
            onPressed: () => isFsnapshot.data == true
                ? unfriend(widget.username)
                : addFriend(widget.username),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),
              ),
            ),
            child: Row(
              children: [
                Icon(
                    isFsnapshot.data == true
                        ? Icons.person_remove_outlined
                        : Icons.person_add_outlined,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  isFsnapshot.data == true ? "FRIEND" : "ADD FRIEND",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.labelLarge!.fontSize),
                ),
              ],
            ),
          );
        });
  }
}
