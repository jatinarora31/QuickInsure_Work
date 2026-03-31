import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final Completer<void> completer;
  AddTodo(this.title,this.description,this.completer);
}

class DeleteTodo extends TodoEvent {
  final int id;
  DeleteTodo(this.id);
}