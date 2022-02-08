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
        title: Text('Founder Blocks Progress'),
        backgroundColor: Color(0XFF3366FF),
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
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () => userLoginPage(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0XFF3366FF))),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () => signUpPage(),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0XFF3366FF))),
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
      print('success');
      showProgressOfStartup();
    } else {
      print('not success');
    }
  }

  Future<void> showProgressOfStartup() async {
    print('home screen opening');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreenAfterLogin()),
    );
  }

  void signUpPage() {
    print('success signup page');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }
}
