import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:convert' as convert;

Future getImage() async {
  var image64 = Uri.parse(
      "http://twowayiot.com:8082/api/GetSingleImageByUniqueID/240/2320391");
  var imageresponse = await http.get(image64);
  final decodedResponse = json.decode(imageresponse.body); //encode
  String img64 = decodedResponse.toString();
  print(img64.toString());

  //final decodedBytes = base64Decode(img64);
  //var file = Io.File("decodedBezkoder.png");
  //file.writeAsBytesSync(decodedBytes);

  //print(file);
}