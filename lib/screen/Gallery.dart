import 'package:flutter/material.dart';

import '../shared/myDrawer.dart';
import '../shared/api.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var gallery;

  @override
  void initState() {
    initGallery();
  }

  void initGallery() async {
    var data = await getGallery();

    setState(() {
      gallery = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Column(
        children: [
          if(gallery != null)
          Expanded(
            child: 
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
              ),
              itemCount: gallery.length,
              itemBuilder: (BuildContext ctx, index) {
                return Image.network(gallery[index]['img'], fit:BoxFit.cover);
              }
            )
          )
        ],
      ) 
    );
  }
}