import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jaijaoni/components/payment/paymen_upload.dart';
import 'package:promptpay_qrcode_generate/promptpay_qrcode_generate.dart';
import 'package:image_picker/image_picker.dart';
import '../custom_app_bar.dart';

class PaymentDetail extends StatefulWidget {
  const PaymentDetail({Key? key, required this.amounts}) : super(key: key);

  final double amounts;

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  File? imagefile;
  final ImagePicker _picker = ImagePicker();
  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagefile = File(pickedFile.path);
        showModalBottomSheet<void>(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Paymentuploadsheet(
                        imagefile: imagefile,
                      )),
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarBuilder(context, text: "Pay", backButton: true),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 55),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Paydetail(
                      amount: widget.amounts,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () {
                    _getFromGallery();
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    padding: const EdgeInsets.all(10.00),
                  ),
                  child: const Text('Upload Payment '),
                ),
              ),
            ),
          ],
        ));
  }
}

class Paydetail extends StatefulWidget {
  const Paydetail({super.key, required this.amount});
  final double amount;

  @override
  State<Paydetail> createState() => PaydetailState();
}

class PaydetailState extends State<Paydetail> {
  // Pay payView = Pay.promptpay;
  int payView = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 290,
          // height: 48,
          child: SegmentedButton<int>(
            segments: const <ButtonSegment<int>>[
              ButtonSegment<int>(
                value: 0,
                label: Text('Promptpay'),
              ),
              ButtonSegment<int>(
                value: 1,
                label: Text('   Bank'),
              )
            ],
            selected: <int>{payView},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                payView = newSelection.first;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: payView == 0
              ? Payqr(
                  amount: widget.amount,
                )
              : Paybank(amount: widget.amount),
        )
      ],
    );
  }
}

class Payqr extends StatelessWidget {
  const Payqr({super.key, required this.amount});
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(maxWidth: 350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
      ),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              // textDirection: TextDirection.ltr,
              "Scan this QR",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize:
                      Theme.of(context).textTheme.headlineLarge!.fontSize),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Align(
              alignment: Alignment.center,
              child: QRCodeGenerate(
                promptPayId: '0962200825',
                amount: amount,
              )),
        ),
      ]),
    );
  }
}

// ignore: camel_case_types
class Paybank extends StatelessWidget {
  const Paybank({super.key, required this.amount});
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 576),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Krungthai',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 48, bottom: 42, right: 48, top: 0),
                child: Text(
                  '203-0-49317-1',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge!.fontSize),
                ),
              )
            ],
          ),
          // )
        ),
        Container(
          margin: const EdgeInsets.only(top: 24),
          constraints: const BoxConstraints(maxWidth: 576),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Amount',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize),
                ),
                Text(
                  amount.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium!.fontSize),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
