import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/BottomNav.dart';
import 'package:jaijaoni/screens/analysis.dart';
import 'package:jaijaoni/screens/create.dart';
import 'package:jaijaoni/screens/detail.dart';
import 'package:jaijaoni/screens/edit.dart';
import 'package:jaijaoni/screens/explore.dart';
import 'package:jaijaoni/screens/friends.dart';
import 'package:jaijaoni/screens/home.dart';
import 'package:jaijaoni/screens/login.dart';
import 'package:jaijaoni/screens/loading.dart';
import 'package:jaijaoni/screens/payment.dart';
import 'package:jaijaoni/screens/profile.dart';
import 'package:jaijaoni/screens/register.dart';

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
    if (dotenv.env['DISABLE_LOGIN'] == "true") return null;
    if (authState.isLoading || authState.hasError) return null;
    final isAuth = authState.valueOrNull != null;
    if (isAuth &&
        (state.location == '/login' || state.location == '/register')) {
      return '/';
    }
    if (!isAuth &&
        (state.location != '/login' && state.location != '/register')) {
      return '/login';
    }
    return null;
  }

  late final routes = [
    ShellRoute(
      routes: [
        ShellRoute(
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: "/analysis",
              builder: (context, state) => const DebtAnalysisScreen(),
            ),
            GoRoute(
              path: "/edit",
              builder: (context, state) => const EditDebtScreen(),
            ),
            GoRoute(
              path: "/explore",
              builder: (context, state) => const ExploreScreen(),
            ),
            GoRoute(
              path: "/firends",
              builder: (context, state) => const FriendsScreen(),
            ),
            GoRoute(
              path: "/profile",
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
          builder: (context, state, child) => Scaffold(
            bottomNavigationBar: const BottomNav(),
            body: child,
          ),
        ),
        GoRoute(
          path: "/create",
          builder: (context, state) => const CreateDebtScreen(),
        ),
        GoRoute(
          path: "/detail",
          builder: (context, state) => const DebtDetailScreen(),
        ),
        GoRoute(
          path: "/payment",
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: "/register",
          builder: (context, state) => const RegisterScreen(),
        ),
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
