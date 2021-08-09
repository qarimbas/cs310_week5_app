import 'package:cs310_week5_app/services/auth.dart';
import 'package:cs310_week5_app/utils/api.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:cs310_week5_app/model/postItem.dart';
import 'package:cs310_week5_app/routes/home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cs310_week5_app/services/database.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int attemptCount = 0;
  String mail = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();

  final AuthService auth = AuthService();

  void getPosts() async {
    //final url = Uri.parse(API.postsURL + '1');
    final url = Uri.parse(API.postsURL);

    final response = await http.get(
      Uri.https(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "charset=UTF-8",
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //SUCCESS
      // print(response.body);
      // showAlertDialog('HTTP Success ${response.statusCode}', 'Posts loaded');

      // Map<String, dynamic> postOne = jsonDecode(response.body);
      // print('User ID: ${postOne['userId']}');
      // print('Title: ${postOne['title']}');

      // PostItem postOne = PostItem.fromJson(jsonDecode(response.body));
      // print(postOne.title);

      var responseList = jsonDecode(response.body) as List;
      List<PostItem> items =
          responseList.map((jsonItem) => PostItem.fromJson(jsonItem)).toList();

      print(items[37].title);
    } else if (response.statusCode >= 400) {
      print(response.body);
      showAlertDialog('HTTP Error ${response.statusCode}', '${response.body}');
    }
  }

  Future<void> showAlertDialog(String title, String message) async {
    bool isIOS = Platform.isIOS;

    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          if (isIOS) {
            return CupertinoAlertDialog(
              title: Text(title),
              content: Column(
                children: [
                  Text(message),
                ],
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
          } else {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
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
          }
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter your e-mail';
                            } else {
                              if (value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              if (!EmailValidator.validate(value)) {
                                return 'The e-mail address is not valid';
                              }
                            }

                            return null;
                          },
                          onSaved: (value) {
                            if (value != null) {
                              mail = value;
                            }
                          },
                          onChanged: (String value) {
                            mail = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter your password';
                            } else {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                            }

                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value ?? '';
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () async {
                            //showAlertDialog("Action", 'Button clicked');
                            //getPosts();

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              var response = await auth.signIn(mail, pass);

                              if (response == null) {
                                showAlertDialog(
                                    'Error', 'Unknown error, cannot sign in');
                              } else if (response.runtimeType is String) {
                                showAlertDialog('Oops', response);
                              } else {
                                Navigator.pushNamed(context, '/home');
                              }

                              setState(() {
                                attemptCount += 1;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Logging in')));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
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
                  Divider(
                    height: 30,
                    color: Colors.black,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              child: Text(
                                'Sign in anonymously',
                                style: kButtonDarkTextStyle,
                              ),
                              onPressed: () async {
                                dynamic response = await auth.signInAnon();

                                if (response == null) {
                                  showAlertDialog('Error',
                                      'Unknown error, cannot sign in.');
                                } else if (response.runtimeType is String) {
                                  showAlertDialog('Oops', response);
                                } else {
                                  //Navigator.pushNamed(context, '/home');

                                }
                              })),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
