import 'package:flutter/material.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/signup.dart';

void main() => runApp(MaterialApp(
      //home: Welcome(),
      //initialRoute: '/login',
      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
    ));
