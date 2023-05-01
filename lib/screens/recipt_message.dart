import 'package:flutter/material.dart';
import 'package:jaijaoni/components/custom_app_bar.dart';
import '../components/circle_avata.dart';

class ReciptMessage extends StatelessWidget {
  const ReciptMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBarBuilder(context, text: "Profile", backButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              circleAvata(radius: 50),
              const SizedBox(height: 15),
              Text(
                "Name's",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
              const SizedBox(height: 21),
              Row(
                children: [
                  const SizedBox(width: 12),
                  Text(
                    "Receipt",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize),
                  ),
                ],
              ),
              receipt(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget receipt(BuildContext context) {
  return Expanded(
    child: Container(
      constraints: const BoxConstraints(maxWidth: 576),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (context, index) => reciptList(context, true),
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: 20,
        ),
      ),
    ),
  );
}

Widget reciptList(BuildContext context, bool read) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          circleAvata(radius: 15),
          const SizedBox(width: 12),
          Text(
            "Sitichok",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
          ),
        ],
      ),
      GestureDetector(
          child: Icon(
              read
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_outlined,
              color: Theme.of(context).colorScheme.primary),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        circleAvata(radius: 30),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sitichock",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .fontSize),
                            ),
                            Text(
                              "@thistine",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .fontSize),
                            ),
                          ],
                        ),
                        const SizedBox(height: 41),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })
    ],
  );
}
