import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/BottomNav.dart';
import 'package:jaijaoni/screens/home.dart';
import 'package:jaijaoni/screens/login.dart';
import 'package:jaijaoni/screens/loading.dart';

import '../providers/authProvider.dart';

// All routes go here.
class AppGoRouter extends ChangeNotifier {
  final Ref ref;
  AppGoRouter({required this.ref}) {
    ref.listen(authValueProvider, (previous, next) {
      notifyListeners();
    });
  }
  late final authState = ref.watch(authValueProvider);

  String? redirectlogic(BuildContext context, GoRouterState state) {
    if (authState.isLoading || authState.hasError) return null;
    final isAuth = authState.valueOrNull != null;
    if (isAuth && state.location == '/login') return '/';
    if (!isAuth && state.location != '/login') return '/login';
    return null;
  }

  late final routes = [
    ShellRoute(
      routes: [
        ShellRoute(
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) => const MyHomePage(title: "Jai Jaoni"),
            ),
          ],
          builder: (context, state, child) => Scaffold(
            bottomNavigationBar: const BottomNav(),
            body: child,
          ),
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const LoginScreen(),
        )
      ],
      builder: (context, state, child) {
        if (authState.isLoading) {
          return const LoadingScreen();
        } else {
          return child;
        }
      },
    )
  ];
}
