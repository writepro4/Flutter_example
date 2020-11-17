//Post 리스트 뷰 위젯

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/widgets/comment.dart';
import 'package:flutter_app2/widgets/my_progress_indicator.dart';
import 'package:flutter_app2/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;


  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    //핸드폰속에 이미지를 저장해 놓고 보여주기 때문에 렉이 없음 고로 사용
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption()
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxx_gap),
      child: Comment(
        showImage: false,
        userName: '원호',
        text: '안녕',
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '12000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //하단 메뉴바 메소드
  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
            color: Colors.black,
            onPressed: null),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/comment.png')),
            color: Colors.black,
            onPressed: null),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
            color: Colors.black,
            onPressed: null),
        Spacer(),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
            color: Colors.black,
            onPressed: null)
      ],
    );
  }

  Widget _postHeader() {
    //가로 정렬 위젯
    return Row(
      children: <Widget>[
        //가로 여백 효과
        Padding(
          padding: const EdgeInsets.all(common_xxx_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text('username')),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(
          containerSize: size.width,
        );
      },
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        );
      },
    );
  }
}
