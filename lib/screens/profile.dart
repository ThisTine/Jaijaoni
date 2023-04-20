//Fah
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvata(),
              Text("Fah"),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CircleAvata() {
  return Container(
    child: const Center(
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 180, 195, 255),
        radius: 50,
        backgroundImage: AssetImage('lib/images/avatar.jpg'),
      ),
    ),
  );
}
