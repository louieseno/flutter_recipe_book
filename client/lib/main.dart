import 'package:client/core/app_pages.dart';
import 'package:client/presenter/home/home_binding.dart';
import 'package:client/presenter/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cookbook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
      home: const HomeScreen(),
    );
  }
}