import 'package:bank_info/app%20utils/app_utils.dart';
import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/screen/homeScreen/homeScreen.dart';
import 'package:bank_info/screen/signUp/sign_in.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String? _email, _password;
  bool _isHide = true;

  void login() async {
    final authService = FirebaseServices();

    if (_email == null || _password == null) {
      showErrorDialog("Please enter your email and password.");
      return;
    }

    try {
      await authService.logInWithEmail(_email!, _password!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } catch (e) {
      showErrorDialog(e.toString());
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Login Error"),
        content: Text(message), // Display a more detailed error message
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void toggleVisibility() {
    setState(() {
      _isHide = !_isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LogIn',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 70),
                Center(
                  child: Icon(
                    Icons.person_pin,
                    size: 200,
                    color: Colors.blue.shade500,
                  ),
                ),
                Card(
                  color: Colors.blue.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900)),
                        TextFormField(
                          validator: (value) =>
                              AppUtil.isValidEmail(value.toString()),
                          onSaved: (email) {
                            _email = email;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Password',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900)),
                        TextFormField(
                          obscureText: _isHide,
                          validator: (value) =>
                              AppUtil.isValidPassword(value.toString()),
                          onSaved: (password) {
                            _password = password;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: toggleVisibility,
                              icon: _isHide
                                  ? Icon(Icons.visibility_off_outlined,
                                      color: Colors.indigo)
                                  : Icon(Icons.visibility_outlined,
                                      color: Colors.indigo),
                            ),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: FilledButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          login();
                        }
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                      style:
                          FilledButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('You Don\'t have an account? '),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
