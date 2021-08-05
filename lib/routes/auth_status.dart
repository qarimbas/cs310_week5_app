import 'package:cs310_week5_app/routes/home.dart';
import 'package:cs310_week5_app/routes/welcome.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key, required this.analytics})
      : super(key: key);

  final FirebaseAnalytics analytics;

  @override
  _AuthenticationStatusState createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Welcome();
    } else {
      return HomeView(analytics: widget.analytics);
    }
  }
}
