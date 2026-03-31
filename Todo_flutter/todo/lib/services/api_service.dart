import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/todo_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("todos")
  Future<List<TodoModel>> getTodos();

  @POST("todos")
  Future<TodoModel> addTodo(@Body() Map<String, dynamic> body);

  @DELETE("todos/{id}")
  Future<void> deleteTodo(@Path("id") int id);
}
//http://127.0.0.1:3000