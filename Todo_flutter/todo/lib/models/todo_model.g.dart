// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  completed: json['is_completed'] as bool,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'is_completed': instance.completed,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
