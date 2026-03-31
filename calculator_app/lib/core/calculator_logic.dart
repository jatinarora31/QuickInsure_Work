class CalculatorLogic {
  String _expression = "";
  String get expression => _expression;

  final List<String> operators = ['+', '-', '*', '/'];

  void addValue(String value) {
    final operators = ['+', '-', '*', '/'];
    if (operators.contains(value)) {
      if (_expression.isEmpty) return;
      if (operators.contains(_expression[_expression.length - 1])) {
        _expression =
            _expression.substring(0, _expression.length - 1) + value;
        return;
      }
    }
    _expression += value;
  }

  void clear() {
    _expression = "";
  }

  void delete() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
    }
  }

  String evaluate() {
    try {
      if (_expression.isEmpty) return "0";

      if (['+', '-', '*', '/'].contains(_expression[_expression.length - 1])) {
        return _expression;
      }
      String exp = _expression.replaceAll('%', '/100');
      double result = _calculate(exp);
      if (result % 1 == 0) {
        _expression = result.toInt().toString();
      } else {
        _expression = result.toString();
      }
      return _expression;
    } catch (e) {
      _expression = "";
      return "ERROR";
    }
  }

  double _calculate(String exp) {
    final matches = RegExp(r'(\d+\.?\d*)|([+\-*/])').allMatches(exp);
    final List<String> tokens = matches.map((m) => m.group(0)!).toList();

    if (tokens.isEmpty) return 0;
    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String op = tokens[i];
      double nextNum = double.parse(tokens[i + 1]);

      switch (op) {
        case '+': result += nextNum; break;
        case '-': result -= nextNum; break;
        case '*': result *= nextNum; break;
        case '/':
          if (nextNum == 0) throw Exception("Divide by zero");
          result /= nextNum;
          break;
      }
    }
    return result;
  }
}