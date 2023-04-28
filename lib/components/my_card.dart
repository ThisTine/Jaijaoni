import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190, //MediaQuery.of(context).size.width * 0.5, //190
      width: 360,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 200,
                      child: Text(
                        "Bonchon Chicken", // Debt Name
                        style: TextStyle(
                            fontSize: 34, color: Colors.white, height: 1.0),
                      ),
                    ),
                    SizedBox(
                      height: 50, // space divider
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        "3/04/23", // Date
                        style: TextStyle(
                            fontSize: 24, color: Colors.white, height: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                            width: 60,
                            child: Row(
                              children: const [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  " +2",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                        const SizedBox(
                          height: 10, // space divider
                        ),
                        const SizedBox(
                          child: Text(
                            "100", // Money amount
                            style: TextStyle(
                                fontSize: 45, color: Colors.white, height: 1.0),
                          ),
                        ),
                        const SizedBox(
                          height: 10, // space divider
                        ),
                        const SizedBox(
                          child: Text(
                            "THB", // THB
                            style: TextStyle(
                                fontSize: 45, color: Colors.white, height: 1.0),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
