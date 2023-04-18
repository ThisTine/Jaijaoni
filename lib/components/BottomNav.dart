import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavItem {
  Widget icon;
  String label;
  String path;
  bool isGo = false;
  NavItem(
      {required this.icon,
      required this.label,
      required this.path,
      this.isGo = false});
}

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    final paths = [
      NavItem(
          icon: const Icon(Icons.home), label: 'Home', path: "/", isGo: true),
      NavItem(icon: const Icon(Icons.add), label: 'Add', path: "/create"),
      NavItem(
          icon: const Icon(Icons.savings),
          label: 'Debt',
          path: "/analysis",
          isGo: true),
      NavItem(
          icon: const Icon(Icons.group),
          label: 'Profile',
          path: "/profile",
          isGo: true),
    ];
    void onChangeRoute(int index) {
      if (paths[index].isGo) {
        context.go(paths[index].path);
      } else {
        context.push(paths[index].path);
      }
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        for (NavItem i in paths)
          BottomNavigationBarItem(icon: i.icon, label: i.label)
      ],
      currentIndex: 0,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      showUnselectedLabels: true,
      onTap: onChangeRoute,
    );
  }
}
