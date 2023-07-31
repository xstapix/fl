import 'package:flutter/material.dart';

import './router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}


// late List<CameraDescription> cameras;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   print('Cameras- $cameras');
  
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: const MyCamera(),
//     );
//   }
// }

// class MyCamera extends StatefulWidget {
//   const MyCamera({super.key});


//   @override
//   State<MyCamera> createState() => _MyCameraState();
// }

// class _MyCameraState extends State<MyCamera> {
//   late CameraController _controller;
//   var selectedCamera = 0;

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(cameras[selectedCamera], ResolutionPreset.max);
//     _controller.initialize().then((_) {
//       if(mounted) {
//          setState(() {});
//       }

//     }).catchError((e) {
//       print(e.description);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return  
    // Scaffold(
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //         width: double.infinity,
    //         height: 500,
    //         child: CameraPreview(_controller),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Container(
    //             padding: EdgeInsets.all(10),
    //             margin: EdgeInsets.all(20),
    //             decoration: BoxDecoration(
    //               color: const Color.fromARGB(255, 255, 255, 255),
    //               borderRadius: BorderRadius.circular(20)
    //             ),
    //             child: const InkWell(
    //               child: Icon(Icons.camera, weight: 50, color: const Color.fromARGB(255, 255, 255, 255),),
    //             )
    //           ),
    //           InkWell(
    //             child: Container(
    //               padding: EdgeInsets.all(10),
    //               margin: EdgeInsets.all(20),
    //               decoration: BoxDecoration(
    //                 color: Colors.blue[600],
    //                 borderRadius: BorderRadius.circular(20)
    //               ),
    //               child: const Icon(Icons.camera, weight: 50, color: Colors.white,),
    //             ),
    //             onTap: () async {
    //               await _controller.setFlashMode((FlashMode.auto));
    //               XFile file = await _controller.takePicture();
          
    //               Navigator.push(
    //                 context, 
    //                 MaterialPageRoute(builder: (context) => ImgPreview(file))
    //               );
    //             },
    //           ),
    //           InkWell(
    //             child:  Container(
    //               padding: EdgeInsets.all(10),
    //               margin: EdgeInsets.all(20),
    //               decoration: BoxDecoration(
    //                 color: Colors.blue[600],
    //                 borderRadius: BorderRadius.circular(20)
    //               ),
    //               child: const Icon(Icons.autorenew_rounded, weight: 50, color: Colors.white,),
    //             ),
    //             onTap: () {
    //               setState(() {
    //                 if (selectedCamera == 0) {
    //                   selectedCamera = 1;
    //                 } else {
    //                   selectedCamera = 0;
    //                 }

    //                 _controller = CameraController(cameras[selectedCamera], ResolutionPreset.max);
    //                 _controller.initialize().then((_) {
    //                   if(mounted) {
    //                     setState(() {});
    //                   }

    //                 });
    //               });
    //             },
    //           )
    //         ],
    //       )
    //     ],
    //   )
    // );
//   }
// }
