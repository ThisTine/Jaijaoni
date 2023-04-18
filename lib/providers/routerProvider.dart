import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../routes/router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final routeRef = AppGoRouter(ref: ref);
  return GoRouter(
      routes: routeRef.routes,
      refreshListenable: routeRef,
      redirect: routeRef.redirectlogic,
      initialLocation: "/");
});
