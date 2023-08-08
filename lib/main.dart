import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './router.dart';
import './store/gallery_bloc/gallery_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GalleryBloc()),
      ], 
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      )
    );
  }
}
 