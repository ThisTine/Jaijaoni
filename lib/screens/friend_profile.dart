import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/quote.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/screens/profile.dart';
import '../components/circle_avata.dart';

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
                        child: circleAvata(radius: 80),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                debtAnalysisBox(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cardProfile(BuildContext context,
    {bool read = false, bool friend = true, required String userId}) {
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
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(
                          children: [
                            Row(
                              children: [
                                circleAvata(radius: 30),
                                const SizedBox(width: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),
                OutlinedButton(
                  onPressed: () {},
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
                          friend
                              ? Icons.person_remove_outlined
                              : Icons.person_add_outlined,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        friend ? "FRIEND" : "ADD FRIEND",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .fontSize),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.ios_share_outlined,
                      color: Theme.of(context).colorScheme.primary),
                  onTap: () {
                    //share to other
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
