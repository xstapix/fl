import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int selectedScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Generation', style: TextStyle(fontSize: 20),),
            selected: selectedScreen == 0,
            onTap: () {
              setState(() {
                selectedScreen = 0;
              });
              context.go('/');
            },
          ),
          ListTile(
            title: const Text('Gallery', style: TextStyle(fontSize: 20),),
            selected: selectedScreen == 1,
            onTap: () {
              setState(() {
                selectedScreen = 1;
              });
              context.go('/gallery');
            },
          ),
        ],
      ) 
    );
  }
}