import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_todo_app/controllers/todo_controller.dart';

class TodoPage extends StatelessWidget {
  TodoPage({super.key});

  final TodoController todoController = Get.put(TodoController());

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ADD TODO"),
          content: TextField(
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  todoController.addTodo(controller.text);
                }
                Navigator.of(context).pop();
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      body: Obx(
        () {
          if (todoController.todos.isEmpty) {
            return const Center(child: Text("Please add todo"));
          }
          return ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              final todo = todoController.todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isComplete
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: todo.isComplete,
                      onChanged: (_) =>
                          todoController.toggleTodo(todo.id, todo.isComplete),
                    ),
                    IconButton(
                      onPressed: () => todoController.deleteTodo(todo.id),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
