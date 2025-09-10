import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'app/bindings/app_binding.dart';
import 'app/routes/app_pages.dart';
import 'constants/constants.dart';

void main() async { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.home,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}