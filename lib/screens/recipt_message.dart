import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/circle_avata.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/debt_detail_payer_card.dart';
import 'package:jaijaoni/components/utils/profile_circle_avatar.dart';
import 'package:jaijaoni/functions/create/get_friends.dart';
import 'package:jaijaoni/functions/friends/find_transaction_from_friend_id.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';

class ReciptMessage extends StatelessWidget {
  const ReciptMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBarBuilder(context, text: "Profile", backButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder(
            future: findUserById(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: profilepic(),
                    builder: (context, snapshot) {
                      return circleAvataUser(
                          radius: 50, imgUrl: snapshot.data.toString());
                    }),
                const SizedBox(height: 15),
                Text("${snapshot.data?.name}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize)),
                const SizedBox(height: 21),
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      "Receipt",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .fontSize),
                    ),
                  ],
                ),
                receipt(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget receipt(BuildContext context) {
  return Expanded(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 576),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: FutureBuilder<List<FriendData>>(
        future: getFriends(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (context, index) => reciptList(
              context,
              true,
              snapshot.data![index],
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: snapshot.data?.length ?? 0,
          ),
        ),
      ),
    ),
  );
}

Widget reciptList(BuildContext context, bool read, FriendData snapshot) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          ProfileCircleAvatar(userId: snapshot.id),
          const SizedBox(width: 12),
          Text(snapshot.name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize:
                      Theme.of(context).textTheme.headlineSmall!.fontSize)),
        ],
      ),
      GestureDetector(
          child: Icon(
              read
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_outlined,
              color: Theme.of(context).colorScheme.primary),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: FutureBuilder(
                    future: findTransactionFromFriendId(snapshot.id),
                    builder: (context, transacSnapshot) {
                      return ListView(
                        children: [
                          Row(
                            children: [
                              ProfileCircleAvatar(userId: snapshot.id),
                              const SizedBox(width: 24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.name,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .fontSize)),
                                  Text("@${snapshot.username}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .fontSize)),
                                ],
                              ),
                              const SizedBox(height: 41),
                            ],
                          ),
                          const SizedBox(height: 27),
                          ...(transacSnapshot.data ?? []).map(
                            (e) {
                              // print(e.transac.transactionId);
                              return PayerCard(
                                reason: e.transac.errMessage,
                                dId: e.debtId,
                                tId: e.transac.transactionId,
                                name: e.transac.username,
                                // image: e.borrowId,
                                amount: e.transac.amount,
                                circleColorState: e.transac.isApproved,
                                // reason: e.transac.,
                                // done: true, circleColorState: e.borrowId,
                              );
                            },
                          ).toList()
                        ],
                      );
                    }),
              ),
            );
          })
    ],
  );
}
