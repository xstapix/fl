import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

var _url = 'https://app.rocketai.ru';

Future sendWork(file) async {
  List<int> imageBytes = await file.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  print(base64Image);

  final response = await http.post(
    Uri.parse('https://kronadev.ru/flutter.php'),
    body: jsonEncode(
      {
        "PublicToken": "string",
        "PicBase64": base64Image,
        "Prompt": "",
        "NegPrompt": "",
        "SDModel": "anything-v4.5.ckpt [fbcf965a62]",
        "Model": "string",
        "Module": "string",
        "A": "string",
        "B": "string",
        "ControlWeight": 1,
        "StartingControlStep": 0,
        "EndingControlStep": 1,
        "ControlMode": 2,
        "denoising_strength": 0.7,
        "Steps": 25,
        "cfg_scale": 7,
        "seed": "-1",
        "Type": "txt2img"
      }
    )
  );
  final data = json.decode(response.body);

  print('data ${data}');

  return data;
}