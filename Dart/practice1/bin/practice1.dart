import 'package:practice1/practice1.dart' as practice1;
import 'dart:io';

int add(int a, int b) {
  return a+b;
}

void checkAge(int age) {
  if(age>=18){
    print("You are eligible for vote");
  }
  else {
    print("You are not eligible for vote");
  }
}

void checkNullSafety() {
  int? a = 0;
  a = null;
  print(a);
}

void inputOutput() {
  print('Enter name');
  String? name = stdin.readLineSync();
  print('Enter Age');
  String? age = stdin.readLineSync();
  num.tryParse(age ?? "0");
  print('Your Name: ${name!}');
  print('Your Age: ${age!}');
}

String stringManipulation() {
  var message = StringBuffer('Dart is fun');
  for(int i=0;i<5;i++) {
    message.write('!');
  }
  return 'Message: ${message.toString()} and Length: ${message.length}';
}

void optionalParameter(String from, String msg, [String? optional, int? a]) {
  var result = '$from says $msg';
  print(result);
  if (optional != null) {
    print('$result with $optional $a times');
  }
}

void main(List<String> arguments) {
  print('Hello world: ${practice1.calculate()}!');
  print('Result of 5 and 9: ${add(5,9)}');
  checkAge(20);
  checkNullSafety();
  // inputOutput();
  print(stringManipulation());
  optionalParameter('JATIN', 'Learn Dart', 'Flutter',10);
}
