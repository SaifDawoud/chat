import 'package:flutter/material.dart';

import './screens/camera_screen.dart';
import 'package:camera/camera.dart';
import './screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogInScreen(),
    );
  }
}
