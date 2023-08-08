import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({this.path, super.key});
  var path;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<String> _list = ['Generation', 'Gallery'];
  final List<bool> selectedScreen = [false, false];

  void handlerDrawer(index) {
    switch (index) {
      case 0:
        context.go('/');
        
        break;
      case 1:
        context.go('/gallery');
        
        break;
    }
    
    print(widget.path);


    for (var i = 0; i < selectedScreen.length; i++) {
      selectedScreen[i] = false;
    }

    selectedScreen[index] = true;

    setState(() {});
  }

  @override
  void initState() {
    switch (widget.path) {
      case '/':
        selectedScreen[0] = true;
        
        break;
      case '/gallery':
        selectedScreen[1] = true;
        
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: 
      ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile( 
            title: Text(
              _list[index], 
              style: TextStyle(
                fontSize: 20,
                color: selectedScreen[index] ? Color.fromRGBO(30, 136, 229, 1) : Colors.black
              ),
            ),
            onTap: () {
              handlerDrawer(index);
            } 
          );
        }
      ),
      // ListView(
      //   children: [
      //     ListTile(
      //       title: const Text('Generation', style: TextStyle(fontSize: 20)),
      //       onTap: () {
      //         context.go('/');
      //         handlerDrawer(0);
      //       },
      //     ),
      //     ListTile(
      //       title: const Text(
      //         'Gallery', 
      //         style: TextStyle(
      //           fontSize: 20, 
      //           color: selectedScreen[1] ? Color.fromRGBO(30, 136, 229, 1) : Colors.black,
      //         )
      //       ),
      //       onTap: () {
      //         context.go('/gallery');
      //         handlerDrawer(1);
      //       },
      //     ),
      //   ],
      // ) 
    );
  }
}