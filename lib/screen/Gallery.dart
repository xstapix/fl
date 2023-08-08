import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import '../shared/myDrawer.dart';
import '../shared/api.dart';
import '../store/gallery_bloc/gallery_bloc.dart';
import '../store/gallery_bloc/gallery_event.dart';
import '../store/gallery_bloc/gallery_state.dart';

const String routePath = '/gallery';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var gallery;

  // @override
  // void initState() {
  //   initGallery();
  // }

  // void initGallery() async {
  //   var data = await getGallery();

  //   setState(() {
  //     gallery = data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final galleryBloc = GalleryBloc();
    galleryBloc.add(GalleryInitEvent());

    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(
        path: routePath
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<GalleryBloc, GalleryState>(
              bloc: galleryBloc,
              builder: (context, state) {
                return GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    if(state is GalleryLoadingState)
                      CircularProgressIndicator(),
                    if(state is GalleryLoadedState)
                      ...state.images.map((obj) => Image.memory(base64Decode(obj['img']), fit: BoxFit.cover)),
                  ],
                );
              }
            ),
          )
        ],
      ) 
    );
  }
}