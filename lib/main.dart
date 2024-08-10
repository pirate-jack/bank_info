
import 'package:bank_info/firebase/authGate.dart';
import 'package:bank_info/firebase_options.dart';
import 'package:bank_info/screen/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.blue
          ),
          //scaffoldBackgroundColor: Colors.blue.shade50
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Splash(),
    );
  }
}
