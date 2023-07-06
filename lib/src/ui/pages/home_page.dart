import 'package:app_cet/src/core/controllers/cet_data_provider.dart';
import 'package:app_cet/src/core/services/authentication_service.dart';
import 'package:app_cet/src/ui/pages/account/login_page.dart';
import 'package:app_cet/src/ui/pages/scanner_page.dart';
import 'package:app_cet/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/home_model.dart';
import '../../core/services/locator.dart';
import 'account/register_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/OrdersPage';
  const HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Column(children: [
              Text('Win up to:', style: context.textTheme.headlineMedium),
              Text(((data?.maxIncentive ?? 0) * 100).toStringAsFixed(0) + '%',
                  style: context.textTheme.headlineLarge),
              Text('On each charge!', style: context.textTheme.headlineMedium),
            ])),
            Center(
              child: isLogedIn
                  ? Column(
                      children: [
                        Text(
                            'Current incentive: ' +
                                ((data?.incentive ?? 0) * 100)
                                    .toStringAsFixed(0) +
                                '%',
                            style: context.textTheme.headlineMedium),
                        Text(
                            'Your balance: ' +
                                (data?.balance ?? 0).toString() +
                                ' SMRG',
                            style: context.textTheme.headlineMedium),
                        data?.walletAddress != null
                            ? QrImageView(
                                data: data?.walletAddress ?? '',
                                version: QrVersions.auto,
                                size: 220.0,
                              )
                            : Text(data?.walletAddress ?? '',
                                style: context.textTheme.headlineSmall),
                        data?.isPowerStationWorker == true? TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Charged Amount',
                            ),
                            controller: TextEditingController(),
                            onChanged: (value) {}):
                        Text(data?.walletAddress ?? '',
                            style: context.textTheme.headlineSmall),
                        data?.isPowerStationWorker == true?ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScannerPage()));
                          },
                          icon: Icon(Icons.login),
                          label: Text('Scan'),
                        ):
                        Text(''),
                      ],
                    )
                  : Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          icon: Icon(Icons.login),
                          label: Text('Sign-in'),
                        ),
                        Expanded(
                            child: SizedBox(
                          height: 10,
                        )),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          icon: Icon(Icons.add),
                          label: Text('Register'),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    )));
  }
}
