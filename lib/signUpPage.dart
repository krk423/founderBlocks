// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameInput = TextEditingController();
  final passwordInput = TextEditingController();
  final emailInput = TextEditingController();
  final startUpInput = TextEditingController();
  final startUpDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Founder Blocks Sign Up'),
          backgroundColor: const Color(0XFF3366FF),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: userNameInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Username'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: passwordInput,
                obscureText: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Password'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Email'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: startUpInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black)),
                    labelText: 'Startup Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: startUpDesc,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black)),
                    labelText: 'Startup Description'),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  child: const Text(
                    'Sign Up',
                  ),
                  onPressed: () => signUp(),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: const Color(0XFF3366FF)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp() async {
    final username = userNameInput.text.trim();
    final email = emailInput.text.trim();
    final password = passwordInput.text.trim();

    final startupInput = startUpInput.text.trim();
    final startupDescription = startUpDesc.text.trim();
    String startUpPointer = '';

    final todo = ParseObject('StartUp')
      ..set('startUpName', startupInput)
      ..set('startUpDescription', startupDescription);
    await todo.save();

    final QueryBuilder<ParseObject> startUpQuery =
        QueryBuilder<ParseObject>(ParseObject('StartUp'));
    startUpQuery.whereContains('startUpName', startupInput);
    final ParseResponse startUpResponse = await startUpQuery.query();
    for (var startUp in startUpResponse.results!) {
      startUpPointer = startUp.get('objectId');
      break;
    }
    print(startUpPointer);
    final user = ParseUser.createUser(
      username,
      password,
      email,
    )..set('startUpPointer',
        (ParseObject('StartUp')..objectId = startUpPointer).toPointer());

    var response = await user.signUp();

    if (response.success) {
      loginRedirect();
    }
  }

  void loginRedirect() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
