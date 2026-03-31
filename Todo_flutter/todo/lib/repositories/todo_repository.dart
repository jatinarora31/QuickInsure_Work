import 'package:todo/models/todo_model.dart';
import 'package:todo/services/api_service.dart';

class TodoRepository{

  final ApiService api;

  TodoRepository(this.api);

  Future<List<TodoModel>> fetchTodos() => api.getTodos();

  Future<TodoModel> addTodo(String title, String description) {
    print("REPO ADD");
    return api.addTodo({"title":title,"description":description});
  }

  Future<void> deleteTodo(int id) => api.deleteTodo(id);

}