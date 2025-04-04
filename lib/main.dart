import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:hemantenterprisesstaff/firebase_options.dart';
import 'package:hemantenterprisesstaff/routes/app_routes.dart';
import 'package:hemantenterprisesstaff/views/splash/splashscreen.dart';


void main() async{
 WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hemant Enterprises Staff',
          home: SplashScreen(),
          getPages: AppRoutes.routes, 
        );
      },
    );
  }
}
