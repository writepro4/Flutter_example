import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/widgets/profile_body.dart';
import 'package:flutter_app2/widgets/profile_side_menu.dart';

//클래스 밖에 선언된 변수일 경우 static 변수로 메모리에 미리 올려짐
const duration = Duration(milliseconds: 1000);

class ProfileScreen extends StatefulWidget {
  //애니메이션 속도값 변수
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final menuWidth = size.width / 3 * 2;

  MenuStatus _menuStatus = MenuStatus.closed;
  double bodyXpos = 0;
  double menuXpos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      //순서 중요 앞으로 올수록 먼저 보여줌 / z-index와 비슷
      body: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            curve: Curves.fastOutSlowIn,
            child: ProfileBody(onMenuChanged: () {
              setState(() {
                //삼항연산자
                _menuStatus = (_menuStatus == MenuStatus.closed)
                    ? MenuStatus.opned
                    : MenuStatus.closed;

                //스위치 문
                switch (_menuStatus) {
                  case MenuStatus.opned:
                    bodyXpos = -menuWidth;
                    menuXpos = size.width - menuWidth;
                    break;
                  case MenuStatus.closed:
                    bodyXpos = 0;
                    menuXpos = size.width;
                    break;
                }
              });
            }),
            transform: Matrix4.translationValues(bodyXpos, 0, 0),
          ),
          //Positioned위젯은 Stack안에서만 사용가능
          AnimatedContainer(
            duration: duration,
            curve: Curves.fastOutSlowIn,
            transform: Matrix4.translationValues(menuXpos, 0, 0),
            child: ProfileSideMenu(menuWidth),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opned, closed }
