import 'package:flutter/material.dart';

import '../screens/edit.dart';
// import 'package:jaijaoni/screens/detail_creator.dart';

class DetailCard extends StatefulWidget {
  final String id;
  final Color? cardColor;
  final String name;
  final String amount;
  final bool edit;

  const DetailCard({
    super.key,
    required this.id,
    required this.cardColor,
    required this.name,
    required this.amount,
    required this.edit,
  });

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              if (widget.edit == true) ...[
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditDebtScreen(
                              debtId: widget.id,
                            ))),
                // context.go("/detail/${widget.id}")
              ] else
                ...[]
            },
        child: SizedBox(
          height: 190, //MediaQuery.of(context).size.width * 0.5, //190
          width: 360,
          child: Card(
            color: widget.cardColor, // Theme.of(context).colorScheme.primary,
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
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  width: 200,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: widget.name,
                                          style: const TextStyle(
                                            fontSize: 34,
                                            color: Colors.white,
                                            height: 1.0,
                                          ),
                                        ),
                                        // const WidgetSpan(
                                        //   child: Padding(
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 15.0),
                                        //     child: Icon(Icons.edit,
                                        //         color: Colors.white),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.edit == false)
                          ...[]
                        else ...[
                          const Icon(Icons.edit, color: Colors.white),
                          const SizedBox(
                            height: 10, // space divider
                          ),
                        ],
                        SizedBox(
                          child: Text(
                            widget.amount, // Money amount
                            style: const TextStyle(
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
                    ))
              ],
            ),
          ),
        ));
  }
}
