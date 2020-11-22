import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/camera_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/screen_size.dart';
import 'file:///C:/Users/write/AndroidStudioProjects/flutter_app2/lib/screens/feed_screen.dart';
import 'package:flutter_app2/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  // createState 상태 변화 감지
  @override
  _HomePageState createState() => _HomePageState();
}

//State를 상속받은 클래스에서만 setState를 사용가능함
class _HomePageState extends State<HomePage> {
  //하단 네비게이션 바
  List<BottomNavigationBarItem> btMNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: "plus"),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: "cross"),
    BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "school"),
  ];

  int _seletedIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  static List<Widget> _screens = <Widget>[
    FeedScreen(),
    Container(
      color: Colors.amberAccent,
    ),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.greenAccent,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: _seletedIndex,
        children: _screens,
      ),
      //네비 설정 부분
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: btMNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        //currentIndex 이놈이 어디 순서인지 알아챔
        currentIndex: _seletedIndex,
        //onTap 부분에 실행할 메소드 선언
        onTap: _onBtnItemClick,
      ),
    );
  }

  void _onBtnItemClick(int index) {
    switch (index) {
      case 2:
        //카메라창은 아예 새로운 창으로 넘김
        _openCamera();
        break;

      default:
    }

    print(index);
    //setState로 상태 변화 알려줌
    setState(() {
      _seletedIndex = index;
    });
    _seletedIndex = index;
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context))
      //stack에 쌓여 Photo페이지에 백버튼 표시됨
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => CameraScreen()));
    else {
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용해줘야 사용 가능'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.microphone].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}
