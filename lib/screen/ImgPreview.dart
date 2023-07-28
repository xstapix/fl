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
  var imgBase64Decode;
  var haveDataBase64 = false;
  var effect;
  bool normal_map_bool = false;
  bool lineart_bool = false;
  bool loadingImg = false;

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

  void handlerBar(index) async {
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
      appBar: AppBar(
        title: Text('Photo preview'),
      ),
      body: ListView(
        children: [
          if(haveDataBase64)
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Image.memory(imgBase64Decode),
            ),
          if(!haveDataBase64)
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Image.file(pic)
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: lineart_bool, 
                          onChanged: (newBool) {
                            setState(() {
                              effect = 'lineart';
                              lineart_bool = newBool!;
                            });
                          }
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              effect = 'lineart';
                              lineart_bool ? lineart_bool = false : lineart_bool = true;
                            });
                          },
                          child: const Text(
                            'lineart',
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13.0),
                          ),
                        ),
              
                      ]
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: normal_map_bool, 
                          onChanged: (newBool) {
                            setState(() {
                              effect = 'normal_map';
                              normal_map_bool = newBool!;
                            });
                          }
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              effect = 'normal_map';
                              normal_map_bool ? normal_map_bool = false : normal_map_bool = true;
                            });
                          },
                          child: const Text(
                            'normal_map',
                            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 300,
                            color: Colors.amber,
                          ),
                          Container(
                            width: 300,
                            color: Color.fromARGB(255, 4, 110, 61),
                          ),
                          Container(
                            width: 300,
                            color: Color.fromARGB(255, 108, 2, 156),
                          )

                        ],
                      ),
                    ),
                    // ListView(
                    //   padding: const EdgeInsets.all(8),
                    //   children:[
                    //     Container(
                    //       decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    //       height: 300,
                    //       color: const Color.fromARGB(255, 7, 238, 255),
                    //     ),
                    //         Container(
                    //                                     decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                    //       height: 300,
                    //       color: const Color.fromARGB(255, 7, 238, 255),
                    //     ),
                    //     Container(
                    //                                 decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                    //       height: 300,
                    //       color: const Color.fromARGB(255, 7, 238, 255),
                    //     ),
                    //   ],
                    // ),
                    
                  ],
                ),
                if(loadingImg)
                  Center(
                    child: Container(
                      height: 50,
                      color: Colors.blue[600],
                      alignment: Alignment.center,
                      child: Text("Loading...", style: TextStyle(color: Colors.white),)
                    ),
                  )
              ]
            ),
        ],
      ),
      // Column(
      //   children: [
      //     if(haveDataBase64)
      //       Center(
      //         child: Image.memory(base64Decode(dataBase64)),
      //       ),
      //     if(!haveDataBase64)
      //       Center(
      //         child: Image.file(pic)
      //       ),
      //   ]
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: (index) {handlerBar(index);},
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt_rounded, color: Colors.blue[600]),
            label: ''
          ),
          if(!haveDataBase64)
            BottomNavigationBarItem(
              icon: Icon(Icons.send_sharp, color: Colors.blue[600],),
              label: '',
            ),

          if(haveDataBase64)
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_rounded, color: Colors.blue[600],),
              label: '',
            ),
        ]
      ),
    );
  }
}