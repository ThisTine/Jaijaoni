import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/auth/auth_service.dart';

final authProvider = Provider((ref) => AuthService());

final authValueProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authProvider);
  return authService.user;
});
