import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'video_page.dart';

import 'package:gallery_saver/gallery_saver.dart';





class VideoPlayer extends StatefulWidget{
  const VideoPlayer({Key? key}) : super(key: key);
  @override
  _VideoPlayerState createState() => _VideoPlayerState();

}


class _VideoPlayerState extends State<VideoPlayer> {

  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;


  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.first;
    //final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      await GallerySaver.saveVideo(file.path);
      setState(() => _isRecording = false);

      Navigator.of(context).pop();


      //如果要有回放功能打開這邊 + video_page.dart
      // final route = MaterialPageRoute(
      //   fullscreenDialog: true,
      //   builder: (_) => VideoPage(filePath: file.path),
      // );
      // Navigator.push(context, route);


      //File(file.path).deleteSync();
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CameraPreview(_cameraController),
            Padding(
              padding: const EdgeInsets.all(25),
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(_isRecording ? Icons.stop : Icons.circle),
                onPressed: () => _recordVideo(),
              ),
            ),
          ],
        ),
      );
    }
  }
}


////////////////////////////
// return Center(
// child: Stack(
// alignment: Alignment.bottomCenter,
// children: [
// CameraPreview(_cameraController),
// Padding(
// padding: const EdgeInsets.all(25),
// child: FloatingActionButton(
// backgroundColor: Colors.red,
// child: Icon(_isRecording ? Icons.stop : Icons.circle),
// //onPressed: () => _recordVideo(),
// onPressed: () => _recordVideo(),
// ),
// ),
// ],
// ),
// );