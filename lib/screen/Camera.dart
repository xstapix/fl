import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../shared/myDrawer.dart';

late List<CameraDescription> cameras;
const String routePath = '/';

class MyCamera extends StatefulWidget {
  const MyCamera({super.key});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  late CameraController _controller;
  bool initController = false;
  var selectedCamera = 0;

  @override
    void initState() {
      super.initState();
      initCameras();
    }

    void initCameras() async {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
      print('Cameras- $cameras');

      _controller = CameraController(cameras[selectedCamera], ResolutionPreset.max);
      _controller.initialize().then((_) {
        if(mounted) {
          initController = true;
          setState(() {});
        }

      }).catchError((e) {
        print(e.description);
      });
    }

  @override
  Widget build(BuildContext context) {
    
    return  
    Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(
        path: routePath,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(!initController)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.4,
            ),
          if(initController)
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.33,
              child: CameraPreview(_controller),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const InkWell(
                  child: Icon(Icons.camera, weight: 50, color: const Color.fromARGB(255, 255, 255, 255),),
                )
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Icon(Icons.camera, weight: 50, color: Colors.white,),
                ),
                onTap: () async {
                  await _controller.setFlashMode((FlashMode.auto));
                  XFile file = await _controller.takePicture();
          
                  context.go('/generation', extra: file);
                },
              ),
              InkWell(
                child:  Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const Icon(Icons.autorenew_rounded, weight: 50, color: Colors.white,),
                ),
                onTap: () {
                  setState(() {
                    if (selectedCamera == 0) {
                      selectedCamera = 1;
                    } else {
                      selectedCamera = 0;
                    }

                    _controller = CameraController(cameras[selectedCamera], ResolutionPreset.max);
                    _controller.initialize().then((_) {
                      if(mounted) {
                        setState(() {});
                      }

                    });
                  });
                },
              )
            ],
          )
        ],
      )
    );
  }
}