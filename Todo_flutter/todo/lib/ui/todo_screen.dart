import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_state.dart';
import 'package:todo/ui/add_todo_screen.dart';
import 'package:todo/ui/todo_detail_screen.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // centerTitle: true,
        title: const Text(
          "All todos",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => (AddTodoScreen()))); },
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add,color: Colors.black),
      ),

      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {

          if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          else if (state is TodoLoaded) {

            if (state.todos.isEmpty) {
              return const Center(
                child: Text(
                  "No Tasks Available",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];

                return GestureDetector(
                  onTap: () {
                    print("Clicked: ${todo.title} ${todo.description}");
                    Navigator.push(context, MaterialPageRoute(builder: (_) => TodoDetailScreen(todo: todo)));
                  },

                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                DateFormat('dd MMM').format(DateTime.parse(todo.createdAt)),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                todo.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  decoration: todo.completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                todo.description,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          else if (state is TodoError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}