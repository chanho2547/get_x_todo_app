class Todo {
  String id;
  String title;
  bool isComplete;

  Todo({required this.id, required this.title, required this.isComplete});

  factory Todo.fromJson(Map<String, dynamic> json, String id) {
    return Todo(
      id: id,
      title: json['title'],
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isComplete': isComplete,
    };
  }
}
