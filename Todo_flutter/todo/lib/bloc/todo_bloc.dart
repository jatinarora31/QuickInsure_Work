import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc(this.repository) : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(
      LoadTodos event, Emitter<TodoState> emit) async {
    print("EVENT CALLED");
    emit(TodoLoading());
    try {
      final todos = await repository.fetchTodos();
      print("DATA -> $todos");
      emit(TodoLoaded(todos));
    } catch (e) {
      print("ERROR$e");
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onAddTodo(
      AddTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final current = (state as TodoLoaded).todos;
      print("BLOC ADD");
      final newTodo = await repository.addTodo(event.title,event.description);
      emit(TodoLoaded([...current, newTodo]));
      event.completer.complete();
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodo event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final current = (state as TodoLoaded).todos;
      await repository.deleteTodo(event.id);
      emit(TodoLoaded(
          current.where((t) => t.id != event.id).toList()));
    }
  }
}