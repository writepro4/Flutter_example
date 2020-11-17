import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appbar(),
            ProfileBody(),
          ],
        ),
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
          onPressed: null,
        )
      ],
    );
  }
}
