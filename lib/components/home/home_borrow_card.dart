import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaijaoni/functions/utils/get_image.dart';

class BorrowCard extends StatefulWidget {
  final String id;
  final String name;
  final String date;
  final String amount;
  final String image;
  final String profileId;
  final int debtor;
  const BorrowCard({
    super.key,
    required this.id,
    required this.name,
    required this.date,
    required this.amount,
    required this.image,
    required this.debtor,
    required this.profileId,
  });

  @override
  State<BorrowCard> createState() => _BorrowCardState();
}

class _BorrowCardState extends State<BorrowCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: 190, //MediaQuery.of(context).size.width * 0.5, //190
        width: 360,
        child: Material(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color(0xFFB05D5D),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.0),
            onTap: () => {
              // GoRouter.of(context).go("/detail/${widget.id}")
              context.push("/detail/${widget.id}")
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 6,
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
                                    FutureBuilder(
                                      future: getPicture(
                                          widget.profileId, "profile_pic"),
                                      builder: (context, snapshot) {
                                        return CircleAvatar(
                                          foregroundImage:
                                              NetworkImage(snapshot.data ?? ""),
                                          backgroundImage: const AssetImage(
                                              "assets/profile.jpg"),
                                          radius: 15,
                                        );
                                      },
                                    ),
                                    if (widget.debtor > 1) ...[
                                      Text(
                                        "+${widget.debtor - 1}",
                                        style: const TextStyle(
                                            color: Colors.white),
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
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 45,
                                    color: Colors.white,
                                    height: 1.0,
                                    overflow: TextOverflow.visible),
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
      ),
    ));
  }
}
