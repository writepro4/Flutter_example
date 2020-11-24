import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraState extends ChangeNotifier {
  CameraController _controller;
  CameraDescription _cameraDescription;
  bool _readytakePhoto = false;

  void dispose() {
    if (_controller != null) _controller.dispose();
    _controller = null;
    _cameraDescription = null;
    _readytakePhoto = false;
    notifyListeners();
  }

  void getReadyToTakePhoto() async {
    List<CameraDescription> cameras = await availableCameras();

    if (cameras != null && cameras.isNotEmpty) {
      setCameraDescription(cameras[0]);
    }

    bool init = false;
    while (!init) {
      init = await initalize();
    }

    _readytakePhoto = true;
    notifyListeners();
  }

  void setCameraDescription(CameraDescription cameraDescription) {
    _cameraDescription = cameraDescription;
    _controller = CameraController(_cameraDescription, ResolutionPreset.medium);
  }

  Future<bool> initalize() async {
    try {
      await _controller.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController get controller => _controller;

  CameraDescription get description => _cameraDescription;

  bool get isReadyToTakePhoto => _readytakePhoto;
}
