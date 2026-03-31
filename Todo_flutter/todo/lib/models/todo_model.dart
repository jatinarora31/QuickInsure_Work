import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {

  final int id;
  final String title;
  final String description;

  @JsonKey(name: "is_completed")
  final bool completed;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "updated_at")
  final String updatedAt;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}