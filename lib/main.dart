import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'screen/ImgPreview.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  print('Cameras- $cameras');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyCamera(),
    );
  }
}

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});


  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if(mounted) {
         setState(() {});
      }

    }).catchError((e) {
      print(e.description);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 500,
            child: CameraPreview(_controller),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 75, 214),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: InkWell(
                    child: Icon(Icons.camera, weight: 50, color: Colors.white,),
                    onTap: () async {
                      await _controller.setFlashMode((FlashMode.auto));
                      XFile file = await _controller.takePicture();
              
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => ImgPreview(file))
                      );
                    },
                  )
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
