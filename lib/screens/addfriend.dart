import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/friends/scan_add_friend.dart';
import 'package:jaijaoni/components/friends/view_qr_add_friend.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  int navIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: "Add friend"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "View QR")
        ],
        currentIndex: navIndex,
        onTap: (value) {
          setState(() {
            navIndex = value;
          });
        },
      ),
      appBar: customAppBarBuilder(context,
          text: navIndex == 0 ? "Scan QR to add friend." : "Add Friend",
          backButton: true),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 576, minHeight: MediaQuery.of(context).size.height),
          child:
              navIndex == 0 ? const ScanAddFriend() : const ViewQRAddFriend(),
        ),
      ),
    );
  }
}
