import 'dart:developer';
import 'package:app_cet/src/ui/pages/account/mnemonic_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  static const String routeName = '/RegisterPage';
  const RegisterPage();
  @override
  Widget build(BuildContext context) {
    log('^^^^^^^^^^^^^^^^^^^^^^^^^^^^ RegisterPage.build');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Account'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Your name',
              ),
              //controller: param1Controller,
              //onTap: () => param1Controller.selection = TextSelection(
              //    baseOffset: 0,
              //    extentOffset: param1Controller.value.text.length)
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MnemonicPage()));
                    },
                    child: const Text('Create Account'))),
          ))
        ],
      ),
    );
  }
}
