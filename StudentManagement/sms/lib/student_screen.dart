import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms/student.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mathsController = TextEditingController();
  TextEditingController englishController = TextEditingController();
  TextEditingController hindiController = TextEditingController();

  List<Student> students = [];

  void onSave() {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        mathsController.text.isEmpty ||
        englishController.text.isEmpty ||
        hindiController.text.isEmpty) {
      return;
    }

    Student student = Student(
      name: nameController.text,
      age: int.parse(ageController.text),
      maths: int.parse(mathsController.text),
      english: int.parse(englishController.text),
      hindi: int.parse(hindiController.text),
    );

    setState(() {
      students.add(student);
    });

    // Clear fields
    nameController.clear();
    ageController.clear();
    mathsController.clear();
    englishController.clear();
    hindiController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Student Management",
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Serif"),
        ),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: nameController,decoration: const InputDecoration(labelText: "Name",border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: ageController,decoration: const InputDecoration(labelText: "Age",border: OutlineInputBorder())),
            const SizedBox(height: 20),
            Container(decoration: BoxDecoration(color:Colors.greenAccent,borderRadius: BorderRadius.circular(20)),padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),child:Text("Enter your marks",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black))),
            const SizedBox(height: 15),
            Row(children: [

              Expanded(child: TextField(controller:mathsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "maths",border: OutlineInputBorder()))),const SizedBox(width: 8),
              Expanded(child: TextField(controller:englishController,decoration: const InputDecoration(labelText: "english",border: OutlineInputBorder()))),const SizedBox(width: 8),
              Expanded(child: TextField(controller:hindiController,decoration: const InputDecoration(labelText: "hindi",border: OutlineInputBorder())))
            ],),const SizedBox(height: 20),
            Container(width:350,child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),onPressed: onSave ,child: Text("Save",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),),
            const SizedBox(height: 20),
            Expanded(
              child: students.isEmpty
                  ? const Text("No students added")
                  : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final s = students[index];

                  return Card(
                    child: ListTile(
                      title: Text(s.name),
                      subtitle: Text(
                          "Age: ${s.age} | M: ${s.maths}, E: ${s.english}, H: ${s.hindi}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
