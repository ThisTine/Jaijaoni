import 'package:flutter/material.dart';
import 'package:jaijaoni/screens/detail_creator.dart';
import 'package:jaijaoni/screens/detail_customer.dart';

class HomeCard extends StatefulWidget {
  final Color cardColor;
  final String name;
  final String date;
  final String amount;
  final String image;
  final int debtor;
  const HomeCard({
    Key? key,
    required this.cardColor,
    required this.name,
    required this.date,
    required this.amount,
    required this.image,
    required this.debtor,
  }) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190, //MediaQuery.of(context).size.width * 0.5, //190
      width: 360,
      child: GestureDetector(
        onTap: () => {
          if (widget.cardColor == const Color(0xFF5DB08D)) ...[
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DetailCreator()))
          ] else ...[
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DetailCustomer()))
          ]
        },
        child: Card(
          color: widget.cardColor, //Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 10,
                //use flexible 10 to make the debt name take the appropriate width size
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name, // Debt Name
                        style: const TextStyle(
                            fontSize: 34, color: Colors.white, height: 1.0),
                      ),

                      // const SizedBox(
                      //   height: 80, // space divider
                      // ),
                      const Spacer(
                        flex: 1,
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.date, // Date
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white, height: 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              width: 70,
                              child: Row(
                                children: [
                                  const SizedBox(width: 13),
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(15),
                                      child: Image.asset(
                                        widget.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if (widget.debtor > 1) ...[
                                    Text(
                                      "+${widget.debtor - 1}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ] else
                                    ...[]
                                ],
                              )),
                          const SizedBox(
                            height: 10, // space divider
                          ),
                          SizedBox(
                            child: Text(
                              widget.amount, // Money amount
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  height: 1.0),
                            ),
                          ),
                          const SizedBox(
                            height: 10, // space divider
                          ),
                          const SizedBox(
                            child: Text(
                              "THB", // THB
                              style: TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  height: 1.0),
                            ),
                          ),
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
