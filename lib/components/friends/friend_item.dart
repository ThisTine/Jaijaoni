import 'package:flutter/material.dart';
import 'package:jaijaoni/components/friends/addfriend_alert_dialog.dart';
import 'package:jaijaoni/components/friends/unfriend_alert_dialog.dart';
import 'package:jaijaoni/functions/friends/accept_firend_request.dart';
import 'package:jaijaoni/functions/friends/reject_friend_request.dart';
import 'package:jaijaoni/providers/friends/show_snackbar.dart';
import 'package:jaijaoni/screens/friend_profile.dart';

class FriendItem extends StatelessWidget {
  final bool isFriend;
  final String name;
  final String username;
  final String profile;
  final bool isRequest;
  final bool isRequestSent;
  final Function getData;
  final String id;
  const FriendItem(
      {super.key,
      required this.getData,
      this.isRequestSent = false,
      this.isFriend = false,
      required this.id,
      required this.name,
      required this.username,
      this.profile = "",
      this.isRequest = false});
  @override
  Widget build(BuildContext context) {
    void unfriend() async {
      bool? isConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) => unfriendAlert(context, username),
      );
      if (isConfirmed == true) {
        getData();
      }
    }

    void addFriend() async {
      bool? isConfirmed = await showDialog<bool>(
        context: context,
        builder: (context) => addfriendAlert(context, username),
      );
      if (isConfirmed == true) {
        getData();

        // DO UNFRIEND LOGIC
      }
      // ADD FRIEND LOGIC
    }

    void acceptRequest() async {
      // print("Accepting request");
      acceptFriendRequest(username).then((value) {
        getData();
      }).onError((error, stackTrace) {
        showSnackBar(context, error.toString());
      });
      // ACCEPTING REQUEST
    }

    void declineRequest() async {
      // print("Rejecting request");

      rejectFriendRequest(username).then((value) {
        getData();
      }).onError((error, stackTrace) {
        showSnackBar(context, error.toString());
      });
      // DECLINING REQUEST
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FriendProfile(
                          fid: id,
                        )));
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(foregroundImage: NetworkImage(profile)),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        "@$username",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              ),
              isRequest
                  ? isRequestSent
                      ? OutlinedButton(
                          onPressed: () => declineRequest(),
                          child: const Text("Cancel"))
                      : SegmentedButton(
                          segments: const [
                            ButtonSegment(
                                value: "ACCEPT",
                                label: Text("Accept"),
                                icon: Icon(Icons.check)),
                            ButtonSegment(
                                value: "DECLINE",
                                label: Text("Decline"),
                                icon: Icon(Icons.close))
                          ],
                          selected: const {},
                          emptySelectionAllowed: true,
                          onSelectionChanged: (p0) => p0.contains("ACCEPT")
                              ? acceptRequest()
                              : declineRequest(),
                        )
                  : IconButton(
                      onPressed: isFriend ? unfriend : addFriend,
                      icon: Icon(
                        isFriend
                            ? Icons.person_remove_outlined
                            : Icons.person_add_alt_outlined,
                        color: Theme.of(context).colorScheme.primary,
                      ))
            ],
          ),
        ),
      ],
    );
  }
}
