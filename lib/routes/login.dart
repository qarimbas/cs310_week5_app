import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int attemptCount;

  Future<void> showDialogBox(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(children: [
                Text(message),
              ]),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void getData() async {
    String name = await Future.delayed(Duration(seconds: 3), () {
      return 'B. Kerem KURT';
    });

    String uni = await Future.delayed(Duration(seconds: 1), () {
      return 'Sabanci University';
    });

    print('$name: $uni');
  }

  @override
  void initState() {
    super.initState();
    print('initState called');
    attemptCount = 0;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print('Build called');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: kAppBarTitleTextStyle,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: Dimen.regularPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have pushed the button this many times:',
              style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.headline4),
            ),
            Text(
              '$attemptCount',
              style: GoogleFonts.lato(
                  fontStyle: FontStyle.italic,
                  textStyle: Theme.of(context).textTheme.headline4),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialogBox('Action', 'Button Clicked');
                      setState(() {
                        attemptCount++;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'Login Attempt: $attemptCount',
                        style: kButtonDarkTextStyle,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
