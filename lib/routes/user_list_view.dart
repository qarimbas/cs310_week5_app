import 'package:cs310_week5_app/model/appuser.dart';
import 'package:cs310_week5_app/routes/user_tile.dart';
import 'package:cs310_week5_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListview extends StatefulWidget {
  const UserListview({Key? key}) : super(key: key);

  @override
  _UserListviewState createState() => _UserListviewState();
}

class _UserListviewState extends State<UserListview> {
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<List<AppUser?>>(context);

    return Column(children: [
      //(condition_test == true) ? do_this_if_true : do_this_if_false
      userList.length == 0
          ? Center(
              child: Text(
                'No Users found',
                style: kButtonLightTextStyle,
              ),
            )
          : Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserTile(
                    user: userList[index]!,
                  );
                },
              ),
            )
    ]);
  }
}
