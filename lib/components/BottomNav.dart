import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        BottomNavigationBarItem(icon: Icon(Icons.savings), label: 'Debt'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Profile'),
      ],
      currentIndex: 0,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      showUnselectedLabels: true,
    );
  }
}
