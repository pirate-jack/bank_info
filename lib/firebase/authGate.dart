import 'package:bank_info/screen/homeScreen/homeScreen.dart';
import 'package:bank_info/screen/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authgate extends StatelessWidget {
  const Authgate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Homescreen();
            }else{
              return Login();
            }
          }
      ),
    );
  }
}