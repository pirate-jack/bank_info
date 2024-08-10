import 'package:bank_info/app%20utils/app_utils.dart';
import 'package:bank_info/firebase/firebase_services.dart';
import 'package:bank_info/model/user_model.dart';
import 'package:bank_info/screen/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

bool _isHide = true;

String? _email, _password, _cpassword, _name;

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();

  void _toggelVisibal() {
    setState(() {
      _isHide = !_isHide;
    });
  }

  FirebaseServices _firebaseServices = FirebaseServices();

  Future<void> _register() async {
    if (_name == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter your name.')));
      return;
    }

    User? user = await _firebaseServices.signInwithEmail(_email!, _password!);
    UserModel userModel =
        UserModel(name: _name!, email: _email!, password: _password!);
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
      }).catchError((error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save user data.')));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')));
    }
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
                  'SignIn',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                        Text(
                          '  Name',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
                        TextFormField(
                          validator: (value) =>
                              AppUtil.isValidName(value.toString()),
                          onSaved: (name) {
                            _name = name;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '  Email',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '  Password',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900),
                        ),
                        TextFormField(
                          validator: (value) =>
                              AppUtil.isValidPassword(value.toString()),
                          onSaved: (password) {
                            _password = password;
                          },
                          obscureText: _isHide,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                _toggelVisibal();
                              },
                              icon: _isHide
                                  ? Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.indigo,
                                    )
                                  : Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.indigo,
                                    ),
                            ),
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '  Confirm Password',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade900),
                        ),
                        TextFormField(
                          validator: (value) {
                            return AppUtil.isValidPassword(value.toString());
                          },
                          onSaved: (Cpassword) {
                            _cpassword = Cpassword;
                          },
                          obscureText: _isHide,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue.shade50,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: FilledButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            _register();

                            print("$_name,$_email , $_password");
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You Already have account ?'),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(color: Colors.blue.shade800),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
