import 'package:flutter/material.dart';
import 'package:flutter_app2/screens/camera_screen.dart';
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

  void _openCamera() {
    //stack에 쌓여 Photo페이지에 백버튼 표시됨
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CameraScreen()));
  }
}
