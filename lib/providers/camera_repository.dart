import 'package:camera/camera.dart';

class CameraRepository {
  List<CameraDescription> _cameras = [];
  late CameraController _controller;
  late Future initializeControllerFuture;
  XFile? image;

  Future<void> _loadCameras() async {
    try {
      _cameras = await availableCameras();
      startCamera();
    } on CameraException catch (error) {
      print(error.description);
    }
  }

  startCamera() async {
    await _loadCameras();
    if (_cameras.isEmpty) {
      print('Camera não foi encontrada');
    } else {
      _previewCamera(_cameras.first);
      initializeControllerFuture = _controller.initialize();
      await initializeControllerFuture;
    }
  }

  CameraPreview showPreview() {
    return CameraPreview(_controller);
  }

  _previewCamera(CameraDescription camera) {
    _controller = CameraController(camera, ResolutionPreset.medium,
        enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg);
  }

  Future<XFile> takePicture() async {
    final image = await _controller.takePicture();
    return image;
  }
}
