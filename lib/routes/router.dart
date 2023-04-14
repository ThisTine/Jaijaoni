import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/BottomNav.dart';
import 'package:jaijaoni/pages/home.dart';
import 'package:jaijaoni/pages/login.dart';

// All routes go here.
final router = GoRouter(
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
      builder: (context, state) => const LoginPage(),
    )
  ],
  // redirect: (context, state) => '/login',
);
