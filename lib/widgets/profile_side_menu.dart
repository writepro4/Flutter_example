import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/screens/auth_screen.dart';

class ProfileSideMenu extends StatelessWidget {
  final double menuWidth;

  const ProfileSideMenu(
    //this.menuWidth를 중괄호 밖에 놔둬야됨
    this.menuWidth, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Container 사이즈 조정 위젯
    return SafeArea(
      child: SizedBox(
        width: menuWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Setting',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              title: Text('Sign out'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
