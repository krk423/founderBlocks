import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'nsfIHhi4mGmLuYu5XF3oN98WTDArsin2xHWyPCfQ';
  const keyClientKey = 'cRSA2cKESCNkSYy0nrcQEGd9e9BaEkeGP19ZkRax';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MaterialApp(home: LoginPage()));
}
