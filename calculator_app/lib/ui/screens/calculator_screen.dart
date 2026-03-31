import 'package:calculator_app/core/calculator_logic.dart';
import 'package:calculator_app/ui/widgets/button.dart';
import 'package:calculator_app/ui/widgets/display.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic logic = CalculatorLogic();

  void onButtonPress(String value) {
    setState(() {
      if(value == 'C') {
        logic.clear();
      } else if(value == 'DEL') {
        logic.delete();
      } else if(value == '=') {
        logic.evaluate();
      } else {
        logic.addValue(value);
      }
    });
  }

  Widget buildRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((b) {
          return CalcButton(
            text: b,
            onTap: () => onButtonPress(b),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Display(text: logic.expression),
          ),
          buildRow(["C","DEL","%","/"]),
          buildRow(["7","8","9","*"]),
          buildRow(["4","5","6","-"]),
          buildRow(["1","2","3","+"]),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CalcButton(
                  text: "0",
                  onTap: () => onButtonPress("0"),
                ),
                CalcButton(
                  text: ".",
                  onTap: () => onButtonPress("."),
                ),
                CalcButton(
                  text: "=",
                  flex: 2,
                  onTap: () => onButtonPress("="),
                ),
              ],
            ),
          ),
          const SizedBox(height: 0)
        ],
      ) ));
  }

}