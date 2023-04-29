import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViewQRAddFriend extends StatelessWidget {
  const ViewQRAddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Theme.of(context).colorScheme.primaryContainer,
      // borderRadius: BorderRadius.all(Radius.circular(20)),
      // elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: QrImage(
                  data: "@thistine",
                  backgroundColor: Colors.white,
                  embeddedImage: const NetworkImage(
                      "https://www.thistine.com/img/me.webp"),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      "Sittichok",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      "@thistine",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
