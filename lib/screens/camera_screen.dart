import 'package:camera/camera.dart';
import 'package:chat_sojsmon/screens/camera_view.dart';

import 'package:flutter/material.dart';
import '../pages/video_view_page.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  Future<void> cameraValue;
  bool isRecording = false;
  bool isFrontCamera = false;
  bool flash = false;
  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CameraPreview(cameraController));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            flash = !flash;
                          });
                          flash
                              ? cameraController.setFlashMode(FlashMode.torch)
                              : cameraController.setFlashMode(FlashMode.off);
                        },
                      ),
                      GestureDetector(
                          onLongPress: () async {
                            await cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onLongPressUp: () async {
                            XFile video =
                                await cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (contex) => VideoPreviewPage(
                                      path: video.path,
                                    )));
                          },
                          onTap: () {
                            if (!isRecording) takePic(context);
                          },
                          child: isRecording
                              ? Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : Icon(Icons.panorama_fish_eye,
                                  size: 70, color: Colors.white)),
                      IconButton(
                        icon: Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          setState(() {
                            isFrontCamera = !isFrontCamera;
                          });
                          int camPos = isFrontCamera ? 1 : 0;
                          cameraController = CameraController(
                              cameras[camPos], ResolutionPreset.high);
                          cameraValue = cameraController.initialize();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hold for video, tap for Photo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePic(BuildContext context) async {
    final XFile image = await cameraController.takePicture();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CameraViewPage(
              path: image.path,
            )));
  }
}
