
import 'package:flutter/material.dart';

Widget circleAvata({required double radius}) {
  return Center(
    child: CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage('images/avatar.jpg'),
    ),
  );
}
