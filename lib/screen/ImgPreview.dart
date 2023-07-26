import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../shared/api.dart';

class ImgPreview extends StatefulWidget {
  ImgPreview(this.file, {super.key});
  XFile file;

  @override
  State<ImgPreview> createState() => _ImgPreviewState();
}

class _ImgPreviewState extends State<ImgPreview> {
  
  Uint8List bytesImage = const Base64Decoder().convert(b64);


  void handlerSendImg(file) async {
    // FormData formData = new FormData.from({
    //   "name": "wendux",
    //   "file1": new File(widget.file)
    // });
    await sendWork(file);
  }

  void handlerSaveImg(file) async {
    String name = file.name;
    String url = file.path;
    print('saveImage ${url}');
    
    final tempDit = await getTemporaryDirectory();
    final path = '${tempDit.path}/$name';

    await GallerySaver.saveImage(path);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Success saved'))
    );
  }

  void handlerBar(index) async {
    switch (index) {
      case 0:
        handlerSaveImg(widget.file);
        break;
      case 1: 
        handlerSendImg(widget.file);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    File pic = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo preview'),
      ),
      body: Center(
        child: Image.memory(bytesImage, width: 200, height: 200),
        ),
      // Center(
      //   child: Image.file(pic)
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,   // <-- HERE
        showUnselectedLabels: false,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: (index) {handlerBar(index);},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt_rounded, color: Colors.blue[600]),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.send_sharp, color: Colors.blue[600],),
            label: '',
          ),
        ]
      ),
    );
  }
}