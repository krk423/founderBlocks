import 'package:flutter/material.dart';
import 'package:founderblocks/homeScreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'signUpPage.dart';
import 'homeScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameInput = TextEditingController();
  final passwordInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Founder Blocks Progress'),
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
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () => userLoginPage(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0XFF3366FF))),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () => signUpPage(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0XFF3366FF))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void userLoginPage() async {
    final username = userNameInput.text.trim();
    final password = passwordInput.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      showProgressOfStartup();
    } else {
      print('not success');
    }
  }

  Future<void> showProgressOfStartup() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreenAfterLogin()),
    );
  }

  void signUpPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
