import 'package:app_cet/src/core/controllers/cet_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'mobile_scanner_overlay.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage();
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late CetDataProvider provider;
  late int totalWattCharged = 10;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CetDataProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
              // facing: CameraFacing.back,
              // torchEnabled: false,
            ),
            onDetect: (capture) {
              final String? address = capture.barcodes.firstOrNull?.rawValue;
              if (address == null) return;
              provider
                  .sendIncentives(address, totalWattCharged)
                  .then((value) => Navigator.pop(context));
            }),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
      ],
    )));
  }
}
