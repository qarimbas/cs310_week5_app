import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:cs310_week5_app/services/auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cs310_week5_app/routes/login.dart';
import 'package:cs310_week5_app/routes/signup.dart';
import 'package:provider/provider.dart';
import 'package:cs310_week5_app/routes/auth_status.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return MaterialApp(
            home: FirebaseFailedView(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppBase();
        }
        return MaterialApp(home: WaitingView());
      },
    );
  }
}

class AppBase extends StatelessWidget {
  const AppBase({
    Key? key,
  }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: AuthenticationStatus(analytics: analytics),
        navigatorObservers: [observer],
        routes: {
          'welcome': (context) => Welcome(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/home': (context) => HomeView(analytics: analytics),
        },
      ),
    );
  }
}

class FirebaseFailedView extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Connecting to server....')),
    );
  }
}
