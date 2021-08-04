import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }

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
                  signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        body: Center(child: Text('Welcome home')),
      ),
    );
  }
}
