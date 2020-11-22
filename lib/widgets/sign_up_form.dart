import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/home_page.dart';
import 'package:flutter_app2/widgets/auth_input_decor.dart';
import 'package:flutter_app2/widgets/or_divider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  //form의 상태를 저장하고 있는 키
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //컨트롤러는 dispose로 리소스 관리를 해주어야함
  //안하면 나중에 힘들어짐
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                controller: _emailController,
                decoration: textInputDecor('Email'),
                //값 확인 함수
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return "정확한 메일 주소 입력바람.";
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _pwController,
                decoration: textInputDecor('Password'),
                obscureText: true,
                //값 확인 함수
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return "제대로 입력바람";
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                controller: _cpwController,
                //입력창 깜빡이는 모션 컬러
                cursorColor: Colors.black54,
                obscureText: true,
                decoration: textInputDecor('Confirm Password'),
                //값 확인 함수
                validator: (text) {
                  if (text.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return "확인바람";
                  }
                },
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                onPressed: null,
                textColor: Colors.blue,
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                label: Text('Login with Facebook'),
              )
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      color: Colors.blue,
      child: Text(
        'join',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('validation success!');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    );
  }
}



