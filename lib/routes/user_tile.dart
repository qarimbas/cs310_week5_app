import 'package:cs310_week5_app/model/appuser.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({Key? key, required this.user}) : super(key: key);

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: kButtonLightTextStyle),
            Text('Last login date: ${user.date}', style: kLabelLightTextStyle),
          ],
        ),
      ),
    );
  }
}
