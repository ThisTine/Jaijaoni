//Tine
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/friends/friend_list_container.dart';
import 'package:jaijaoni/components/friends/friend_request_container.dart';
import 'package:jaijaoni/components/friends/username_search.dart';
import 'package:jaijaoni/config/theme/custom_text_field.dart';
import 'package:jaijaoni/providers/friends/friends_request_provider.dart';
import 'package:jaijaoni/screens/addfriend.dart';
import '../functions/friends/find_friend_request.dart';
import '../functions/utils/find_user_by_username.dart';
import '../model/friends_req.model.dart';
import '../model/user.model.dart';
import '../providers/friends/friends_provider.dart';
import '../providers/friends/show_snackbar.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  final TextEditingController _searchController =
      TextEditingController(text: "");
  String toggleMode = "FRIEND_LIST";
  int friendRequestCount = 0;
  void openQR() async {
    String data = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddFriendScreen()));
    if (data != "") {
      _onSearchChanged(data);
      setState(() {
        toggleMode = "FRIEND_LIST";
        _searchController.text = data;
      });
    }
  }

  Users? usr;
  FriendsReqs? request;
  Timer? _debounce;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void getData() {
    setState(() {
      isLoading = true;
    });
    findFriendRequest(_searchController.text.substring(1)).then((value) {
      setState(() {
        request = value;
      });
    }).onError((error, stackTrace) {
      // showSnackBar(context, error.toString());
    });

    findUserByUsername([_searchController.text.substring(1)]).then((value) {
      setState(() {
        usr = value.first;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Couldn't find ${_searchController.text}");
    });
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {});
      if (query.startsWith("@") && query.length > 1) {
        getData();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friendsStream = ref.watch(friendsProvider);
    final friendsRequestStream = ref.watch(friendsRequestProvider);

    return Scaffold(
      appBar: customAppBarBuilder(context,
          text: "Friends",
          backButton: true,
          actions: [
            IconButton(
                onPressed: () {
                  openQR();
                },
                icon: Icon(
                  Icons.qr_code,
                  color: Theme.of(context).colorScheme.primary,
                ))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 576, minHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SegmentedButton(
                    segments: [
                      const ButtonSegment(
                          value: "FRIEND_LIST", label: Text("Friend List")),
                      ButtonSegment(
                          value: "FRIEND_REQUEST",
                          label: Text("Request ($friendRequestCount) "))
                    ],
                    selected: {toggleMode},
                    onSelectionChanged: (p0) {
                      setState(() {
                        toggleMode = p0.first;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: roundInput.copyWith(
                          labelText: "Search",
                          hintText: "Friend's name or username",
                          suffixIcon: const Icon(Icons.search)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _searchController.text.startsWith("@")
                      ? UsernameSearch(
                          getData: getData,
                          isLoading: isLoading,
                          usr: usr,
                          request: request,
                        )
                      : toggleMode.contains("FRIEND_LIST")
                          ? friendsStream.when(
                              data: (data) {
                                if (data.isEmpty) {
                                  return const Text(
                                      "ํYou don't have friends at this moment.");
                                }
                                return FriendListContainer(
                                  friends: [...data],
                                  searchData: _searchController.text,
                                );
                              },
                              error: (error, stackTrace) =>
                                  Text(error.toString()),
                              loading: () => const CircularProgressIndicator())
                          : friendsRequestStream.when(
                              data: (data) {
                                if (data.isEmpty) {
                                  return const Text(
                                      "There's no friend request at this moment.");
                                }
                                setState(() {
                                  friendRequestCount = data.length;
                                });
                                return FriendRequestContainer(
                                  friends: [...data],
                                  searchData: _searchController.text,
                                );
                              },
                              error: (error, stackTrace) =>
                                  Text(error.toString()),
                              loading: () => const CircularProgressIndicator())
                  // FriendItem(),
                  // FriendItem(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
