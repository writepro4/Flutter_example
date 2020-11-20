import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/screens/profile_screen.dart';
import 'package:flutter_app2/widgets/rounded_avatar.dart';

//git test
//setState로 값이 변경된걸 감지하면
//앱 화면 다시 렌더링
//statefulwidget 위젯으로 변경하고 나면 앱자체를 다시 시작해줘야됨.
class ProfileBody extends StatefulWidget {
  final Function onMenuChanged;

  const ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.left;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            //그리드 + 리스트뷰 같이 사용할때 사용하면 됨
            //CustomScrollView를 사용할때는 반드시 Expanded 위젯을 붙여야됨.
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(common_gap),
                          child: RoundedAvatar(
                            size: 80,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: common_gap),
                            child: Table(
                              children: [
                                TableRow(children: [
                                  _valueText("post"),
                                  _valueText('post'),
                                  _valueText('post'),
                                ]),
                                TableRow(children: [
                                  _labelText('Post'),
                                  _labelText('Followers'),
                                  _labelText('Followings'),
                                ])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    _userName(),
                    _userBio(),
                    _editProfileBtn(),
                    _tabButtons(),
                    _seletedIndicator(),
                  ]),
                ),
                _imagePager()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
          "The Coding Papa",
          textAlign: TextAlign.center,
        )),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            widget.onMenuChanged();
          },
        )
      ],
    );
  }

  Text _valueText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      );

  Text _labelText(String label) => Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 11,
        ),
      );

  //이미지 페이지 애니메이션 변경 메소드
  SliverToBoxAdapter _imagePager() {
    print("확인");
    print(_leftImagesPageMargin);
    print(_rightImagesPageMargin);
    return SliverToBoxAdapter(
        child: Stack(children: [
      AnimatedContainer(
        duration: duration,
        transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
        curve: Curves.fastOutSlowIn,
        child: _images(),
      ),
      AnimatedContainer(
        duration: duration,
        transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
        curve: Curves.fastOutSlowIn,
        child: _images(),
      ),
    ]));
  }

  GridView _images() {
    return GridView.count(
      crossAxisCount: 3,
      //그리드뷰 자체 사이즈를 유한하게 설정하려면 true값
      shrinkWrap: true,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: 'https://picsum.photos/id/$index/100/100'),
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
              color: _selectedTab == SelectedTab.left
                  ? Colors.black
                  : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                _tabSelected(SelectedTab.left);
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
              color: _selectedTab == SelectedTab.left
                  ? Colors.black26
                  : Colors.black,
            ),
            onPressed: () {
              _tabSelected(SelectedTab.right);
            },
          ),
        )
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.left:
          _selectedTab = SelectedTab.left;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;

          // TODO: Handle this case.
          break;
        case SelectedTab.right:
          _selectedTab = SelectedTab.right;
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          // TODO: Handle this case.
          break;
      }
    });
  }

  _seletedIndicator() {
    //애니메이션 효과 자동으로 넣어줌
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      alignment: _selectedTab == SelectedTab.left
          ? Alignment.centerLeft
          : Alignment.centerRight,
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
        borderSide: BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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

enum SelectedTab { left, right }
