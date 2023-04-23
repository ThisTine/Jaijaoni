//Fah
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';

import 'create.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvata(radius: 50.0),
                const SizedBox(height: 15),
                Text(
                  "Name" + "'s",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),
                const SizedBox(height: 21),
                DebtAnalysisBox(context),
                const SizedBox(height: 28),
                MenuBox(context),
                const SizedBox(height: 28),
                Quote(context),
                const SizedBox(height: 19),
                LogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget CircleAvata({required double radius}) {
  return Container(
    child: Center(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: AssetImage('images/avatar.jpg'),
      ),
    ),
  );
}

Widget DebtAnalysisBox(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          // constraints: const BoxConstraints(maxWidth: 326),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Debt Analysis",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 119,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "300",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .sourceRedbar,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .fontSize),
                                      ),
                                      Text(
                                        "THB",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .sourceRedbar,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontSize),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                      const SizedBox(height: 2),
                      Text("Unpaid",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(width: 34),
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 119,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "1,500",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .sourceGreenbar,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .fontSize),
                                      ),
                                      Text(
                                        "THB",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .extension<CustomColors>()!
                                                .sourceGreenbar,
                                            fontWeight: FontWeight.bold,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .fontSize),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]),
                      const SizedBox(height: 2),
                      Text("Unpaid",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget MenuBox(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 326),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.push("/create");
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.currency_exchange_outlined,
                                  color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 10),
                              Text(
                                "Create Debt",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .fontSize),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),
              //divider
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context.push("/profile/message");
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.mail_outlined,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Text(
                            "Receipt",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //divider
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context.push("/profile/:fid");
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.group_outlined,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Text(
                            "Friends list",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              //divider
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context.push("/");
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.military_tech_outlined,
                              color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Text(
                            "Debt analysis",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget Quote(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 164,
          constraints: const BoxConstraints(maxWidth: 326),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "\"Quote\"",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .fontSize),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget LogoutButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        primary: Theme.of(context).colorScheme.primaryContainer,
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Log out successfully')),
        );
      },
      child: Text(
        "Log Out",
        style: TextStyle(
            color: Theme.of(context).extension<CustomColors>()!.sourceRedbar,
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize),
      ),
    ),
  );
}
