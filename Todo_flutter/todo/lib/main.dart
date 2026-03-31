import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/core/dio_client.dart';
import 'package:todo/repositories/todo_repository.dart';
import 'package:todo/services/api_service.dart';
import 'package:todo/ui/todo_screen.dart';

import 'bloc/todo_bloc.dart';

void main() {

  final dio = DioClient.getDio();
  final api = ApiService(dio);
  final repository = TodoRepository(api);

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final TodoRepository repository;
  const MyApp(this.repository ,{super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (_) => TodoBloc(repository)..add(LoadTodos()),
          child: TodoScreen()
      ),
    );
  }
}

