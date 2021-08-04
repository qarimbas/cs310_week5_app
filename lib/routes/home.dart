import 'package:cs310_week5_app/services/auth.dart';
import 'package:cs310_week5_app/utils/analytics.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:cs310_week5_app/utils/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'LOGIN',
            style: kAppBarTitleTextStyle,
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () async {
                  await auth.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  onPressed: () {
                    setCurrentScreen(
                        widget.analytics, 'HomeView', 'HomeViewState');
                  },
                  child: Text(
                    'Set current screen',
                    style: kButtonLightTextStyle,
                  )),
              SizedBox(height: 16),
              OutlinedButton(
                  onPressed: () {
                    setUserId(widget.analytics, 'KKURT');
                  },
                  child: Text(
                    'Set userID',
                    style: kButtonLightTextStyle,
                  )),
              SizedBox(height: 16),
              OutlinedButton(
                  onPressed: () {
                    logCustomEvent(
                      widget.analytics,
                      'LoginHome',
                      {'name': 'Barış', 'age': 22, 'isInstructor': false},
                    );
                  },
                  child: Text(
                    'Set current screen',
                    style: kButtonLightTextStyle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
