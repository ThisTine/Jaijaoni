import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jaijaoni/functions/utils/save_token_to_database.dart';

import '../../providers/router_provider.dart';
import '../theme/color_schemes.g.dart';
import '../theme/custom_color.g.dart';

class JaiJaoNi extends ConsumerWidget {
    Future<void> setupToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    await saveTokenToDatabase(token!);

    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }

  const JaiJaoNi({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

        final router = ref.watch(routerProvider);
        return MaterialApp.router(
          title: 'Jai jaoni',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            extensions: [lightCustomColors],
          ),
          // darkTheme: ThemeData(
          //   useMaterial3: true,
          //   colorScheme: darkScheme,
          //   extensions: [darkCustomColors],
          // ),
          routerConfig: router,
        );
      },
    );
  }
}
