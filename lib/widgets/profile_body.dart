import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';

//setState로 값이 변경된걸 감지하면
//앱 화면 다시 렌더링
//statefulwidget 위젯으로 변경하고 나면 앱자체를 다시 시작해줘야됨.
class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool selectedLeft = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //그리드 + 리스트뷰 같이 사용할때 사용하면 됨
      //CustomScrollView를 사용할때는 반드시 Expanded 위젯을 붙여야됨.
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _userName(),
              _userBio(),
              _editProfileBtn(),
              _tabButtons(),
              _seletedIndicator()
            ]),
          ),
        ],
      ),
    );
  }

  Row _tabButtons() {
    return Row(
      //메뉴 버튼 정렬하기
      //또 다른 방법으로 버튼에 각각 Expanded 위젯을 주면 됨
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage(
                'assets/images/grid.png',
              ),
              color: selectedLeft ? Colors.black : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                selectedLeft = true;
              });
            },
          ),
        ),
        Expanded(
          child: IconButton(
            icon: ImageIcon(
              AssetImage(
                'assets/images/saved.png',
              ),
              color: selectedLeft ? Colors.black26 : Colors.black,
            ),
            onPressed: () {
              setState(() {
                selectedLeft = false;
              });
            },
          ),
        )
      ],
    );
  }

  _seletedIndicator() {
    //애니메이션 효과 자동으로 넣어줌
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: selectedLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      //curve 다양한 효과를 줄 수 있다.
      curve: Curves.easeInOut,
    );
  }
}

Padding _editProfileBtn() {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: common_gap, vertical: common_xxx_gap),
    child: SizedBox(
      height: 24,
      child: OutlineButton(
        onPressed: null,
        borderSide: BorderSide(color: Colors.black45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

_userName() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'this is my username',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

_userBio() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: common_gap),
    child: Text(
      'this is what I belive',
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}
