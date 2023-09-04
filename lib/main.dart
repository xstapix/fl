import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './router.dart';
import './store/gallery_bloc/gallery_bloc.dart';
import 'screen/Camera.dart';
import 'screen/Hello.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('account');
  var account = prefs.containsKey('account');

  if (account)
    router.go('/camera');
  else
    router.go('/');

  Widget app = MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Inter'
    ),
    routerConfig: router,
  );

  runApp(app);
}
 