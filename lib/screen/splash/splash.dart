import 'dart:async';


import 'package:bank_info/firebase/authGate.dart';
import 'package:bank_info/screen/login/login.dart';
import 'package:bank_info/screen/signUp/sign_in.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Authgate(),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/icons/splash.png',
                    color: Colors.blue.shade300,
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                'Secure Your \n      Bank \n  Infomation',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
