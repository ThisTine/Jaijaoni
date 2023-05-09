//Fah
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';
import 'package:jaijaoni/functions/profile/user_name.dart';
import 'package:jaijaoni/services/auth/auth_service.dart';

import '../components/circle_avata.dart';
import '../components/quote.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/profile/edit');
            },
            icon:
                Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder<String>(
                future: profilepic(),
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      circleAvataUser(
                        radius: 50.0,
                        imgUrl: snapshot.data ?? '',
                      ),
                      const SizedBox(height: 15),
                      FutureBuilder<String>(
                        future: username(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading...');
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          return Text(
                            ' ${snapshot.data ?? ''}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .fontSize,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      quote(context, height: 100),
                      const SizedBox(height: 15),
                      debtAnalysisBox(context),
                      const SizedBox(height: 15),
                      menuBox(context),
                      const SizedBox(height: 15),
                      logoutButton(context),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

Widget debtAnalysisBox(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 576),
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
                  Container(
                      constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.03,
                  )),
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
                      Text("Paid",
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

Widget menuBox(BuildContext context) {
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
              InkWell(
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
              InkWell(
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
              InkWell(
                onTap: () {
                  context.push("/friends");
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
              InkWell(
                onTap: () {
                  context.push("/analysis");
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

Widget logoutButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      onPressed: () {
        AuthService().logout();
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
