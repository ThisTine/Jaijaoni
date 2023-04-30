import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanAddFriend extends StatefulWidget {
  final Function(String) popWithData;
  const ScanAddFriend({super.key, required this.popWithData});

  @override
  State<ScanAddFriend> createState() => _ScanAddFriendState();
}

class _ScanAddFriendState extends State<ScanAddFriend> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code!.startsWith('@')) {
        widget.popWithData(scanData.code!);
        // Navigator.pop(context, scanData.code);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  overlayColor: const Color.fromARGB(50, 0, 0, 0),
                  borderLength: 20,
                  borderWidth: 20,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8),
            ),
          ),
        ),
      ],
    );
  }
}