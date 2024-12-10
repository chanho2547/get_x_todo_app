import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_todo_app/controllers/auth_controller.dart';
import 'package:get_x_todo_app/views/pages/main_page.dart';
import 'package:get_x_todo_app/views/pages/settings_page.dart';
import 'package:get_x_todo_app/views/screens/login_screen.dart';
import 'package:get_x_todo_app/views/screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      // home: const MainScreen(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/sign_up", page: () => SignUpScreen()),
        GetPage(name: "/main", page: () => const MainPage()),
        GetPage(name: "/settings", page: () => const SettingsPage()),
      ],
    );
  }
}
