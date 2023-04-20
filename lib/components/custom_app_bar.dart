import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget customAppBarBuilder(BuildContext context,
    {required String text, bool backButton = false}) {
  void backButtonHandler() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go("/");
    }
  }

  return AppBar(
    leading: backButton
        ? IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Theme.of(context).colorScheme.primary,
            onPressed: backButtonHandler)
        : null,
    title: Text(
      "Create",
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
    ),
  );
}
