import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/widgets/rounded_avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String userName;
  final String text;
  final DateTime dateTime;

  Comment({
    Key key,
    this.showImage = true,
    @required this.userName,
    @required this.text,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage) RoundedAvatar(size: 24),
        if (showImage)
          SizedBox(
            width: common_gap,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
              children: <TextSpan>[
                //테마 색깔을 따라가기 때문에 따로 컬러 설정을 해줘야됨.
                TextSpan(
                    text: userName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(text: '     '),
                TextSpan(text: text, style: TextStyle(color: Colors.black))
              ],
            )),
            if (dateTime != null)
              Text(
                dateTime.toIso8601String(),
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              )
          ],
        ),
      ],
    );
  }
}
