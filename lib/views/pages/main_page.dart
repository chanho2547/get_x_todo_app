// 메인 화면
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_todo_app/controllers/todo_controller.dart';
import 'package:get_x_todo_app/views/pages/settings_page.dart';
import 'package:get_x_todo_app/views/pages/todo_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
