import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  bool _isSaving = false;

  Future<bool> _onWillPop() async {
    final title = titleController.text.trim();
    final description = descController.text.trim();

    if (_isSaving) return false;

    if (title.isNotEmpty || description.isNotEmpty) {
      _isSaving = true;

      final completer = Completer<void>();

      context.read()<TodoBloc>().add(AddTodo(title, description, completer));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            "Add Todo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "It will automatically save when you go back.",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 50),

              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  labelStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}