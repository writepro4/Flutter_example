import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/common_size.dart';
import 'package:flutter_app2/constants/screen_size.dart';
import 'package:flutter_app2/models/camera_state.dart';
import 'package:flutter_app2/screens/share_post_screen.dart';
import 'package:flutter_app2/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.width,
              color: Colors.black,
              child: (cameraState.isReadyToTakePhoto)
                  ? _getPreview(cameraState)
                  : _progress,
            ),
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  if(cameraState.isReadyToTakePhoto){
                    _attempTakePhoto(cameraState, context);
                  }
                },
                shape: CircleBorder(),
                borderSide: BorderSide(color: Colors.black12, width: 20),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size.width,
              height: size.width / cameraState.controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attempTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try{
      final path = join((await getTemporaryDirectory()).path, '$timeInMilli.png');

      await cameraState.controller.takePicture(path);

      File imageFile = File(path);
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SharePostScreen(imageFile)));

    }catch(e){
      
    }
  }
}
