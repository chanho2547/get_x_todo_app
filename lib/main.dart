import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_todo_app/controllers/todo_controller.dart';
import 'package:get_x_todo_app/views/settings_page.dart';
import 'package:get_x_todo_app/views/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// 메인 화면
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _seletecNavBar = 0;
  final TodoController _todoController = Get.put(TodoController());

  @override
  void initState() {
    super.initState();
    _todoController.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _seletecNavBar,
        children: [
          TodoPage(),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seletecNavBar,
        onTap: (value) {
          setState(() {
            _seletecNavBar = value;
            _todoController.fetchTodos();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today_outlined),
            label: 'TODO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'SETTINGS',
          ),
        ],
      ),
    );
  }
}
