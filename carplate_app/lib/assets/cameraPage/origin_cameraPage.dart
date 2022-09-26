import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

const String _url = 'https://google.com';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<XFile>? _imageFileList;
  final ImagePicker _picker = ImagePicker();

  void _launchUrl() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  void _getImagePicker(ImageSource source, {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      setState(() {
        _imageFileList = pickedFile == null ? null : [pickedFile];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _previewImages() {
    try {
      if (_imageFileList != null) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Image.file(
              File(_imageFileList![index].path),
            );
          },
          itemCount: _imageFileList!.length,
        );
      } else {
        return const Text('請選擇或拍攝相片');
      }
    } catch (e) {
      return Text(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:






















      Center(
        child: _previewImages(),
      ),
      floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: () {
            _getImagePicker(ImageSource.gallery, context: context);
          },
          child: const Icon(Icons.file_copy_outlined),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FloatingActionButton(
            onPressed: () {
              _getImagePicker(ImageSource.camera, context: context);
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
        ),

      ]),
    );
  }
}
