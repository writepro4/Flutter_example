import 'package:flutter/material.dart';

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
    Container(
      color: Colors.amberAccent,
    ),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.greenAccent,
    ),
    Container(
      color: Colors.deepPurpleAccent,
    ),
    Container(
      color: Colors.cyanAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
    print(index);
    //setState로 상태 변화 알려줌
    setState(() {
      _seletedIndex = index;
    });
    _seletedIndex = index;
  }
}
