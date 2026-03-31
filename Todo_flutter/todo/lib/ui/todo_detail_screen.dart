import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class TodoDetailScreen extends StatefulWidget {
  final TodoModel todo;

  const TodoDetailScreen({super.key, required this.todo});

  @override
  State<TodoDetailScreen> createState() => _TodoDetailScreen();

}

class _TodoDetailScreen extends State<TodoDetailScreen> {

  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    descController = TextEditingController(text: widget.todo.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "My Todo",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left:20,right:20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(left:20,top:10)),
            Text(
              "Title",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),Padding(padding: const EdgeInsets.only(left:20)),

            const SizedBox(height: 5),

            Text(
              widget.todo.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            Text(
              "Description",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(children: [
                TextField(
                  controller: descController,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Edit description...",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ],),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}