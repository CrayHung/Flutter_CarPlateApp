import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Zoomable extends StatelessWidget {

  final String imgUrl;

  const Zoomable({Key? key ,required this.imgUrl}) : super(key: key);

  String base64 = base64Encode(image.buffer.asInt64List());
  print(base64);
  Uint8List bytes = base64Decode(imgUrl);
  print(bytes);

  @override
  Widget build(BuildContext context) {

    //print('$imgUrl');

    return Container(

        child: SingleChildScrollView(

          child: SizedBox(
              width: 500.0,
              height: 500.0,
              child: PhotoView(
                imageProvider: NetworkImage(i),
                //imageProvider: MemoryImage(imgUrl),
              )
          ),
        )
    );

  }
}
