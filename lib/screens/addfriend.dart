import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import 'package:jaijaoni/components/friends/scan_add_friend.dart';
import 'package:jaijaoni/components/friends/view_qr_add_friend.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  void popWithData(String data) {
    // print("Poped !");
    // print("This is data : $data");

    // if (Navigator.canPop(context)) {
    //   // Navigator.pop(context, data);
    // }
  }

  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: "Add friend"),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: "View QR")
        ],
        currentIndex: _navIndex,
        onTap: (value) {
          setState(() {
            _navIndex = value;
          });
        },
      ),
      appBar: customAppBarBuilder(context,
          text: _navIndex == 0 ? "Scan QR to add friend." : "Add Friend",
          backButton: true),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
              maxWidth: 576, minHeight: MediaQuery.of(context).size.height),
          child: _navIndex == 0
              ? ScanAddFriend(
                  popWithData: popWithData,
                )
              : const ViewQRAddFriend(),
        ),
      ),
    );
  }
}
