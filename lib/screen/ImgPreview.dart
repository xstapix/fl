import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'package:camera/camera.dart';

import '../shared/api.dart';
import '../shared/myDrawer.dart';

const String routePath = '/';

class ImgPreview extends StatefulWidget {
  ImgPreview(this.file, {super.key});
  var file;

  @override
  State<ImgPreview> createState() => _ImgPreviewState();
}

class _ImgPreviewState extends State<ImgPreview> {
  var imgBase64Decode;
  var haveDataBase64 = false;
  var effect;
  bool normal_map_bool = false;
  bool lineart_bool = false;
  bool loadingImg = false;
  int selectedScreen = 0;

  void handlerSendImg(file) async {
    setState(() {
      loadingImg = true;
    });

    var answer = await sendWork(file);
    
    setState(() {
      imgBase64Decode = base64Decode(answer);
      haveDataBase64 = true;
      loadingImg = false;
    });
  }

  void handlerSaveImg(file) async {
    if (!haveDataBase64) {
      String name = file.name;
      String url = file.path;
      
      final tempDit = await getTemporaryDirectory();
      final path = '${tempDit.path}/$name';

      await GallerySaver.saveImage(path);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success saved'),
          backgroundColor: Colors.blue,
        )
      );
    } else {
      String dir = (await getApplicationDocumentsDirectory()).path;
      String fullPath = '$dir/abc.jpg';

      await GallerySaver.saveImage(fullPath);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Success saved'),
          backgroundColor: Colors.blue,
        )
      );
    }
  } 

  void handlerBar(index) {
    switch (index) {
      case 0:
        handlerSaveImg(haveDataBase64 ? imgBase64Decode : widget.file);
        break;
      case 1: 
        if(!haveDataBase64){

          handlerSendImg({
            'file': widget.file,
            'effect': effect
          });
        } else {
          Navigator.pop(context);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    File pic = File(widget.file.path);

    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(
        path: routePath
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      if(!haveDataBase64)
                        Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: Image.file(pic)
                        ),
                      if(haveDataBase64)
                        Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: Image.memory(imgBase64Decode),
                        ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            InkWell(
                              onTap: () {
                                effect = 'lineart';

                                handlerSendImg({
                                  'file': widget.file,
                                  'effect': effect
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("images/m.jpg"), fit: BoxFit.cover),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: effect == 'lineart' ? Colors.green : Colors.black, 
                                        width: effect == 'lineart' ? 4 : 0
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(103, 255, 255, 255),
                                          Color.fromARGB(192, 0, 0, 0)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    ),
                                    width: 300,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text('Lineart', style: TextStyle(color: Colors.white, fontSize: 40),)
                                      ]
                                    ),
                                  ),
                                ),
                              )
                            ),
                            InkWell(
                              onTap: () {
                                effect = 'normal_map';

                                handlerSendImg({
                                  'file': widget.file,
                                  'effect': effect
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("images/m.jpg"), fit: BoxFit.cover),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: effect == 'normal_map' ? Colors.green : Colors.black, 
                                        width: effect == 'normal_map' ? 4 : 0
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(103, 255, 255, 255),
                                          Color.fromARGB(192, 0, 0, 0)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    ),
                                    width: 300,
                                    child: const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Text('Normal_map', style: TextStyle(color: Colors.white, fontSize: 40),)
                                      ]
                                    ),
                                  ),
                                ),
                              )
                            ),
                            Container(
                              width: 300,
                              color: Color.fromARGB(255, 108, 2, 156),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ],
          ),
          if(loadingImg) 
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromARGB(83, 0, 0, 0),
            ),
          if(loadingImg)
            const AlertDialog(
              title: Text('Loading...'),
              content: Text('Please wait'),
            )
        ],
      ) 
    );
  }
}