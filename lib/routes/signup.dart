import 'dart:convert';

import 'package:cs310_week5_app/services/auth.dart';
import 'package:cs310_week5_app/utils/dimension.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cs310_week5_app/utils/color.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int attemptCount = 0;
  String mail = '';
  String pass = '';
  String pass2 = '';
  String userName = '';
  final _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();

  Future<void> signUpUser() async {
    final url = Uri.parse('http://altop.co/cs310/api.php');
    var body = {
      'call': 'signup',
      'mail': mail,
      'pass': pass,
      'username': userName
    };

    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String>{
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Successful transmission
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for (var entry in jsonMap.entries) {
        print("${entry.key} ==> ${entry.value}");
      }
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for (var entry in jsonMap.entries) {
        print("${entry.key} ==> ${entry.value}");
      }

      showAlertDialog('WARNING', jsonMap['error_msg']);
    } else {
      print(response.body.toString());
      print(response.statusCode);
      showAlertDialog('WARNING', 'Response was not recognized');
    }
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
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
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNUP',
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
                            mail = value ?? '';
                            if (mail.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if (!EmailValidator.validate(mail)) {
                              return 'The e-mail address is not valid';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            mail = value ?? '';
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
                            hintText: 'Username',
                            //labelText: 'Username',
                            labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            userName = value ?? '';
                            if (userName.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if (userName.length < 4) {
                              return 'Username is too short';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            userName = value ?? '';
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
                            pass = value ?? '';
                            if (pass.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (pass.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            pass = value ?? '';
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: true,
                            hintText: 'Password (Repeat)',
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
                            pass2 = value ?? '';

                            if (pass2.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (pass2.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            pass2 = value ?? '';
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
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if (pass != pass2) {
                                showAlertDialog(
                                    "Error", 'Passwords must match');
                              } else {
                                var response = await auth.signUp(mail, pass);

                                if (response == null) {
                                  showAlertDialog('Error',
                                      'Unknown error, cannot sign in.');
                                } else if (response.runtimeType is String) {
                                  showAlertDialog('Oops', response);
                                } else {
                                  Navigator.pushNamed(context, '/home');
                                }
                              }
                              setState(() {
                                attemptCount += 1;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Signing up')));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Sign Up',
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
          ],
        ),
      ),
    );
  }
}
