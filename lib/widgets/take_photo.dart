import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    //카메라 갯수만큼 가져와서 실행시킴?
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child: (snapshot.hasData)
                    ? _getPreview(snapshot.data)
                    : _progress,
              ),
              Expanded(
                child: OutlineButton(
                  shape: CircleBorder(),
                  borderSide: BorderSide(color: Colors.black12, width: 20),
                  onPressed: () {},
                ),
              )
            ],
          );
        });
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);

    return FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return _progress;
          }
        });
  }
}
