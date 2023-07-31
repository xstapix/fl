import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

var _url = 'https://app.rocketai.ru';
String _publicToken = 'dX633jpLpxqVY5cuePqI50FrvyOix5HprsILrV6Sq1Jzh9yoCR0nIm3dYw7nmYBXRghDGLMZx5mBjWj1mYBh1260yrZhnrD6Ipq0woAuZNg8B0jTYC30anHntH4U2Y2iFQXlQFLJS3NrYCFmfqkvPfZ3lavzi3QxTfcNcwGgdiNHa8ZuxPhTWBEFtsTOzW8GoRJBPagY3s8wpWb9C7Y5P6CUcDdnDHwkc0qQaUQEfqHqqHh5DEvpmwgk2wFTbr2';

Future getGallery () async {
  // final response = await http.get(
  //   Uri.parse('$_url/api/v1/gen/control-net'),
  //   headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  // );
  // final data = json.decode(response.body);

  return [
    {
      'img': 'https://s0.rbk.ru/v6_top_pics/media/img/8/54/756578114959548.jpg'
    },
    {
      'img': 'https://www.russiadiscovery.ru/storage/orig/posts/1038/Kavkazskie_gory.jpg'
    },
    {
      'img': 'https://kipmu.ru/wp-content/uploads/mountain.jpg'
    },
    {
      'img': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Moench_2339.jpg/1200px-Moench_2339.jpg'
    },
    {
      'img': 'https://kipmu.ru/wp-content/uploads/mountain.jpg'
    }
  ];
}

Future sendWork(obj) async {
  List<int> imageBytes = await obj['file'].readAsBytes();
  String base64Image = base64Encode(imageBytes);

  final response = await http.post(
    Uri.parse('$_url/api/v1/gen/control-net'),
    body: jsonEncode(
      {
        "PublicToken": _publicToken,
        "SDModel": "deliberate_v2.ckpt [b4391b7978]",
        "Model": "control_v11p_sd15_lineart",
        "Module": obj['effect'],
        "PicBase64": base64Image
      }
    ),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  );
  final data = json.decode(response.body);

  return data['PicBase64'][0];
}

Future txtimg(file) async {
  List<int> imageBytes = await file.readAsBytes();
  String base64Image = base64Encode(imageBytes);

  final response = await http.post(
    Uri.parse('$_url/api/v1/gen/txt2img'),
    body: jsonEncode(
      {
        "PublicToken": _publicToken,
        "Prompt": '',

      }
    ),
    headers: {HttpHeaders.contentTypeHeader: 'application/json'}, 
  );
  final data = json.decode(response.body);

  return data;
}