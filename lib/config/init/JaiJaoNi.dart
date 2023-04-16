import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes/router.dart';
import '../theme/color_schemes.g.dart';
import '../theme/custom_color.g.dart';

class JaiJaoNi extends StatelessWidget {
  const JaiJaoNi({super.key});
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightScheme = lightDynamic.harmonized();
          lightCustomColors = lightCustomColors.harmonized(lightScheme);

          // Repeat for the dark color scheme.
          darkScheme = darkDynamic.harmonized();
          darkCustomColors = darkCustomColors.harmonized(darkScheme);
        } else {
          // Otherwise, use fallback schemes.
          lightScheme = lightColorScheme;
          darkScheme = darkColorScheme;
        }

        return AppRouter(lightScheme: lightScheme, darkScheme: darkScheme);
      },
    );
  }
}

class AppRouter extends ConsumerWidget {
  const AppRouter({
    super.key,
    required this.lightScheme,
    required this.darkScheme,
  });

  final ColorScheme lightScheme;
  final ColorScheme darkScheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Jai jaoni',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        extensions: [lightCustomColors],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkScheme,
        extensions: [darkCustomColors],
      ),
      routerConfig: router,
    );
  }
}
