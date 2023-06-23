import 'dart:developer';
import 'package:app_cet/main_imports.dart';
import 'package:app_cet/src/core/controllers/cet_data_provider.dart';
import 'package:app_cet/src/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/controllers/user_provider.dart';

class MnemonicPage extends StatefulWidget {
  static const String routeName = '/MnemonicPage';
  @override
  State<MnemonicPage> createState() => _MnemonicPageState();
}

class _MnemonicPageState extends State<MnemonicPage> {
  late CetDataProvider provider;
  late UserProvider userProvider;
  late Future<List<String>> data;

  @override
  void initState() {
    provider = Provider.of<CetDataProvider>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    data = provider.generateMnemonic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('^^^^^^^^^^^^^^^^^^^^^^^^^^^^ MnemonicPage.build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Remember these words!'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            children: [
              FutureBuilder<List<String>>(
                  future: data,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      List<Widget> res = new List.empty(growable: true);
                      for (int i = 0; i < snapshot.data!.length; i++) {
                        var word = snapshot.data![i];
                        res.add(Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text((i + 1).toString() + ':'),
                              ),
                            ),
                            SizedBox(
                              width: 60,
                              child: Text(
                                word,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  background: Paint()
                                    ..color = Colors.amber
                                    ..strokeWidth = 19
                                    ..style = PaintingStyle.stroke
                                    ..strokeJoin = StrokeJoin.round,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ));
                      }
                      return Column(children: res);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}',
                          style: context.textTheme.headlineLarge);
                    }
                    // By default, show a loading spinner.
                    return Text('Loading...',
                        style: context.textTheme.headlineLarge);
                  }),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('HAVE YOUR SAVED PASSWORD TO A SECURE PLACE?'),
                      ElevatedButton(
                          onPressed: () {
                            // TODO: Sign-in
                            
                            //userProvider.(loadData: loadData)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          child: const Text('YES, I CONFIRM!')),
                    ],
                  ),
                ),
              ))
            ],
          )),
        ),
      ),
    );
  }
}
