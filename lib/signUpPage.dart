import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
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
          title: Text('Founder Blocks Sign Up'),
          backgroundColor: const Color(0XFF3366FF),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: userNameInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Username'),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                controller: passwordInput,
                obscureText: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Password'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: emailInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Email'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: startUpInput,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Startup Name'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                controller: startUpDesc,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Startup Description'),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: TextButton(
                  child: const Text(
                    'Sign Up',
                  ),
                  onPressed: () => signUp(),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0XFF3366FF)),
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
    final startUpName = startUpInput.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      print('successfully signed Up');
      loginRedirect();
    } else {
      print('some technical error');
    }
  }

  void loginRedirect() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
