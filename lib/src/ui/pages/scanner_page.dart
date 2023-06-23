import 'dart:typed_data';
import 'package:app_cet/src/core/controllers/cet_data_provider.dart';
import 'package:app_cet/src/core/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/home_model.dart';
import '../../core/services/locator.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerPage extends StatefulWidget {
  static const String routeName = '/OrdersPage';
  const ScannerPage();
  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late CetDataProvider provider;
  late HomeModel? data = null;
  late bool isLogedIn = false;

  @override
  void initState() {
    super.initState();
    loadinitData();
  }

  void loadinitData() async {
    provider = Provider.of<CetDataProvider>(context, listen: false);
    provider.load().then((d) => setState(() => this.data = d));
    setState(
        () => this.isLogedIn = locator<AuthenticationService>().isLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CetDataProvider>(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20),
      child: MobileScanner(
        fit: BoxFit.contain,
        controller: MobileScannerController(
          // facing: CameraFacing.back,
          // torchEnabled: false,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
          if (image != null) {
            showDialog(
              context: context,
              builder: (context) => Image(image: MemoryImage(image)),
            );
            Future.delayed(const Duration(seconds: 5), () {
              Navigator.pop(context);
            });
          }
        },
      ),
    )));
  }
}
