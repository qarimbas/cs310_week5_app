import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/signup.dart';

class Wrapper extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            home: FirebaseFailedView(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Welcome(),
            routes: {
              '/login': (context) => Login(),
              '/signup': (context) => SignUp(),
              '/home': (context) => HomeView(),
            },
          );
        }
        return MaterialApp(home: WaitingView());
      },
    );
  }
}

class FirebaseFailedView extends StatelessWidget {
  const FirebaseFailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cannot connect to server'),
      ),
    );
  }
}

class WaitingView extends StatelessWidget {
  const WaitingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Connecting to server....')),
    );
  }
}
