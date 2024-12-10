import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_x_todo_app/models/todo.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final todos = <Todo>[].obs;

  // firestore에서 투두 리스트 가져오기
  Future<void> fetchTodos() async {
    final snapsnot = await _firestore.collection('todos').get();
    todos.value =
        snapsnot.docs.map((doc) => Todo.fromJson(doc.data(), doc.id)).toList();
  }

  // 투두 추가
  Future<void> addTodo(String title) async {
    final docRef = await _firestore.collection('todos').add({
      'title': title,
      'isComplete': false,
    });
    todos.add(Todo(id: docRef.id, title: title, isComplete: false));
  }

  // 투두 토글
  Future<void> toggleTodo(String id, bool isComplete) async {
    await _firestore.collection('todos').doc(id).update({
      'isComplete': !isComplete,
    });
    final index = todos.indexWhere((todo) => todo.id == id);
    todos[index].isComplete = !isComplete;
    todos.refresh();
  }

  // 투두 삭제
  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
    todos.removeWhere((todo) => todo.id == id);
  }
}
