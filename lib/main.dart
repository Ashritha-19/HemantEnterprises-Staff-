import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:hemantenterprisesstaff/providers/brandlistprovider.dart';
import 'package:hemantenterprisesstaff/providers/categorylistprovider.dart';
import 'package:provider/provider.dart';
import 'package:hemantenterprisesstaff/firebase_options.dart';
import 'package:hemantenterprisesstaff/routes/app_routes.dart';
import 'package:hemantenterprisesstaff/views/splash/splashscreen.dart';
import 'package:hemantenterprisesstaff/providers/staffProvider.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StaffProvider()),
        ChangeNotifierProvider(create: (context) => BrandsProvider()),
        ChangeNotifierProvider(create: (context) => Categoriesprovider()),
           
      ],
      child: FlutterSizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hemant Enterprises Staff',
            home: SplashScreen(),
            getPages: AppRoutes.routes,
          );
        },
      ),
    );
  }
}
