//Fah
import 'package:flutter/material.dart';
import 'package:jaijaoni/config/theme/custom_color.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvata(),
              const SizedBox(height: 15),
              Text(
                "Name",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall!.fontSize),
              ),
              const SizedBox(height: 21),
              DebtAnalysisBox(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CircleAvata() {
  return Container(
    child: const Center(
      child: CircleAvatar(
        backgroundColor: Color.fromARGB(255, 180, 195, 255),
        radius: 50,
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
          width: 326,
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
