import 'package:flutter/material.dart';
import 'dart:convert';

import '../shared/myDrawer.dart';
import '../shared/api.dart';

const String routePath = '/gallery';

class DetailGallery extends StatefulWidget {
  const DetailGallery({super.key});

  @override
  State<DetailGallery> createState() => _DetailGalleryState();
}

class _DetailGalleryState extends State<DetailGallery> {
  var detailGallery;

  @override
  void initState() {
    initDetailGallery();
  }

  void initDetailGallery() async {
    var data = await getDetailGallery();

    setState(() {
      detailGallery = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(
        path: routePath
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                child: Image.memory(base64Decode(detailGallery['img']), fit: BoxFit.cover,),
              ),
              Text('data')
            ],
          ) 
        ]
      )
    );
  }
}