import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/components/bottom_nav.dart';
import 'package:jaijaoni/screens/analysis.dart';
import 'package:jaijaoni/screens/create.dart';
import 'package:jaijaoni/screens/detail.dart';
import 'package:jaijaoni/screens/edit.dart';
import 'package:jaijaoni/screens/edit_profile.dart';
import 'package:jaijaoni/screens/explore.dart';
import 'package:jaijaoni/screens/friend_profile.dart';
import 'package:jaijaoni/screens/friends.dart';
import 'package:jaijaoni/screens/home.dart';
import 'package:jaijaoni/screens/login.dart';
import 'package:jaijaoni/screens/loading.dart';
import 'package:jaijaoni/screens/payment.dart';
import 'package:jaijaoni/screens/profile.dart';
import 'package:jaijaoni/screens/recipt_message.dart';
import 'package:jaijaoni/screens/register.dart';
import 'package:jaijaoni/screens/reset_password.dart';

import '../providers/auth_provider.dart';

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
        (state.location == '/login' ||
            state.location == '/register' ||
            state.location == "/reset-password")) {
      return '/';
    }
    if (!isAuth &&
        (state.location != '/login' && state.location != '/register' ||
            state.location == "/reset-password")) {
      return '/login';
    }
    return null;
  }

  final routesWithNav = [
    "/",
    "/analysis",
    "/edit",
    "/explore",
    "/friends",
    "/profile"
  ];
  final GlobalKey<NavigatorState> _mainRouteKey = GlobalKey();
  final GlobalKey<NavigatorState> _shellRouteKey = GlobalKey();

  late final routes = [
    ShellRoute(
      navigatorKey: _mainRouteKey,
      routes: [
        ShellRoute(
          navigatorKey: _shellRouteKey,
          routes: [
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/",
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/analysis",
              builder: (context, state) => const DebtAnalysisScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/edit",
              builder: (context, state) => const EditDebtScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/explore",
              builder: (context, state) => const ExploreScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/profile",
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/profile/message",
              builder: (context, state) => const ReciptMessage(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/profile/edit",
              builder: (context, state) => const EditProfile(),
            ),
            GoRoute(
              parentNavigatorKey: _shellRouteKey,
              path: "/profile/:fid",
              builder: (context, state) =>
                  FriendProfile(fid: state.params['fid']!),
            ),
          ],
          builder: (context, state, child) => Scaffold(
            bottomNavigationBar: BottomNav(path: state.fullpath),
            body: child,
          ),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/friends",
          builder: (context, state) => const FriendsScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/create",
          builder: (context, state) => const CreateDebtScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/detail",
          builder: (context, state) => const DebtDetailScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/payment",
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/login",
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/register",
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          parentNavigatorKey: _mainRouteKey,
          path: "/reset-password",
          builder: (context, state) => const ResetPasswordScreen(),
        )
      ],
      builder: (context, state, child) {
        if (authState.isLoading) {
          return const LoadingScreen();
        } else {
          // for (String i in routesWithNav) {
          //   if (i == state.fullpath &&
          //       ref.read(navigatorProvider.notifier).state == 0) {
          //     return Scaffold(
          //       bottomNavigationBar: BottomNav(
          //         path: state.fullpath,
          //         ref: ref,
          //       ),
          //       body: child,
          //     );
          //   }
          // }

          return child;
        }
      },
    )
  ];
}
