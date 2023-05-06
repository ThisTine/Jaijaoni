import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/utils/find_user_by_id.dart';
import 'package:jaijaoni/model/user.model.dart';
import 'package:jaijaoni/providers/friends/show_snackBar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQRAddFriend extends StatefulWidget {
  const ViewQRAddFriend({super.key});

  @override
  State<ViewQRAddFriend> createState() => _ViewQRAddFriendState();
}

class _ViewQRAddFriendState extends State<ViewQRAddFriend> {
  Users? user;

  @override
  void initState() {
    findUserById(FirebaseAuth.instance.currentUser!.uid).then((value) {
      setState(() {
        user = value;
      });
    }).onError((error, stackTrace) {
      showSnackBar(context, error.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: user == null
          ? const CircularProgressIndicator()
          : Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: QrImage(
                          data: "@${user?.username}",
                          backgroundColor: Colors.white,
                          // embeddedImage: const NetworkImage(
                          //     "https://www.thistine.com/img/me.webp"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              "${user?.name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            Text(
                              "@${user?.username}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
