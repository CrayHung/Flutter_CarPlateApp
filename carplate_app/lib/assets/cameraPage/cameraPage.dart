import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'videoPlayer.dart';





class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late CameraController _cameraController;
  bool _isRecording = false;

  //在使用camera前要做初始化cameraController
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
    _initCamera();
  }


  final ImagePicker _imagePicker = ImagePicker();
  File? image;
  File? galleryVideo;
  List<File> multipleImage = [];


  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /******************************************************/
                //從gallery選 單一 影片
                /******************************************************/
                ElevatedButton(
                  onPressed: () async {
                    XFile? video = await _imagePicker.pickVideo(
                        source: ImageSource.gallery);
                    setState(() {
                      galleryVideo = File(video!.path);
                    });
                  },
                  child: Text('Gallery video'),
                ),
                Expanded(
                  child: galleryVideo == null
                      ? Text("456")
                      : Text("${galleryVideo!.path}")),




                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    /******************************************************/
                    //從gallery選 單一 照片
                    /******************************************************/
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     XFile? pickedImage = await _imagePicker.pickImage(
                    //         source: ImageSource.gallery);
                    //
                    //     setState(() {
                    //       image = File(pickedImage!.path);
                    //     });
                    //   },
                    //   child: Text('Gallery Image'),
                    // ),

                    /******************************************************/
                    //從gallery選 複數 照片
                    /******************************************************/
                    ElevatedButton(
                      onPressed: () async {
                        List<XFile>? picked = await _imagePicker.pickMultiImage(
                            maxHeight: 200, maxWidth: 200);

                        setState(() {
                          multipleImage =
                              picked!.map((e) => File(e.path)).toList();
                        });
                      },
                      child: Text('Multiple Image'),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: multipleImage.length,
                      itemBuilder: (context, index) {
                        return GridTile(
                            child: Image.file(multipleImage[index]));
                      }),
                ),


                /******************************************************/
                //從camera錄 單一 照片
                /******************************************************/
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () async {
                    XFile? pickedImage = await _imagePicker.pickImage(
                        source: ImageSource.camera);
                    //將照片存在gallery中
                    GallerySaver.saveImage(pickedImage!.path).then((path){
                      setState(() {
                        image = File(pickedImage.path);
                      });
                    });



                    // setState(() {
                    //   image = File(pickedImage!.path);
                    // });
                  },
                  child: Text('Camera Image'),
                ),
                Expanded(
                    child: image == null
                        ? Text("")
                        : Image.memory(File(image!.path).readAsBytesSync())
                ),


                /******************************************************/
                //從camera錄 單一 video
                /******************************************************/
                const SizedBox(width: 24),
                ElevatedButton(
                  child:Text('Camera video'),
                  onPressed:() {
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=> const VideoPlayer()));
                  },


                ),



                // /******************************************************/
                // //辨識按鈕
                // /******************************************************/
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.red, // background
                //     onPrimary: Colors.white, // foreground
                //   ),
                //   onPressed: () {
                //
                //   },
                //   child: Text('辨識', style: TextStyle(color: Colors.white)),
                // ),


              ],
            ),
          ),
        ),
      );




  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    _cameraController = CameraController(front, ResolutionPreset.max);
    await _cameraController.initialize();

  }


  //video record
  _recordVideo() async {
    if (_isRecording) {
      final video = await _cameraController.stopVideoRecording();
      //將檔案存到gallery
      await GallerySaver.saveVideo(video.path);
      File(video.path).deleteSync();
      setState(() => _isRecording = false);

    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }
}
