
import 'package:json_annotation/json_annotation.dart';

part 'upsert_todo.g.dart';

@JsonSerializable()
class UpsertTodo {

  final String title;
  final String description;

  UpsertTodo({
    required this.title,
    required this.description
  });

  factory UpsertTodo.fromJson(Map<String, dynamic> json) =>
      _$UpsertTodoFromJson(json);

  Map<String, dynamic> toJson() => _$UpsertTodoToJson(this);

}