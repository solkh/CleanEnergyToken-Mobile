import 'dart:developer';
import 'package:app_cet/src/core/controllers/user_provider.dart';
import 'package:app_cet/src/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserProvider userProvider;
  late List<Widget> res;
  late List<TextEditingController> ctrls;

  @override
  void initState() {
    userProvider = UserProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('^^^^^^^^^^^^^^^^^^^^^^^^^^^^ LoginPage.build');
    res = new List.empty(growable: true);
    ctrls = new List.empty(growable: true);
    for (int i = 0; i < 12; i++) {
      var ctrl = TextEditingController();
      ctrls.add(ctrl);
      //const label = 'Word' + (i+1).toString();
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
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Word',
              ),
              controller: ctrl,
              //onTap: () => param1Controller.selection = TextSelection(
              //    baseOffset: 0,
              //    extentOffset: param1Controller.value.text.length)
            ),
          ),
        ],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-in to your account'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: res,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {
                      // TODO: Sign-in
                      var mnemonic = '';
                      for (int i = 0; i < ctrls.length; i++) {
                        if (i > 0) mnemonic += ' ';
                        mnemonic += ctrls[i].text.trim();
                      }
                      userProvider.loginByMnemonic(mnemonic).then((value) => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage())));
                      
                    },
                    child: const Text('Sign-in'))),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    for (int i = 0; i < ctrls.length; i++) {
      ctrls[i].dispose();
    }
    super.dispose();
  }
}
