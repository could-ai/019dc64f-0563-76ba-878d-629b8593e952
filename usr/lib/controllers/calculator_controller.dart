import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var display = '0'.obs;
  var expression = ''.obs;

  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';
  bool _resetDisplay = false;

  void onNumberPressed(String number) {
    if (display.value == 'Error') {
      onClear();
    }
    
    if (_resetDisplay) {
      display.value = number;
      _resetDisplay = false;
    } else {
      if (display.value == '0') {
        display.value = number;
      } else {
        // Prevent exceeding display bounds, limit to 10 digits
        if (display.value.replaceAll('.', '').replaceAll('-', '').length < 10) {
          display.value += number;
        }
      }
    }
  }

  void onOperatorPressed(String op) {
    if (display.value == 'Error') return;

    if (_operator.isNotEmpty && !_resetDisplay) {
      calculate();
    }
    
    _num1 = double.parse(display.value);
    _operator = op;
    _resetDisplay = true;
    expression.value = '${_formatNumber(_num1)} $_operator';
  }

  void calculate() {
    if (_operator.isEmpty || display.value == 'Error') return;

    _num2 = double.parse(display.value);
    double result = 0;

    switch (_operator) {
      case '+':
        result = _num1 + _num2;
        break;
      case '-':
        result = _num1 - _num2;
        break;
      case '×':
        result = _num1 * _num2;
        break;
      case '÷':
        if (_num2 == 0) {
          display.value = 'Error';
          expression.value = '';
          _operator = '';
          _resetDisplay = true;
          return;
        }
        result = _num1 / _num2;
        break;
    }

    display.value = _formatNumber(result);
    expression.value = '${_formatNumber(_num1)} $_operator ${_formatNumber(_num2)} =';
    _num1 = result;
    _operator = '';
    _resetDisplay = true;
  }

  void onClear() {
    display.value = '0';
    expression.value = '';
    _num1 = 0;
    _num2 = 0;
    _operator = '';
    _resetDisplay = false;
  }

  void onBackspace() {
    if (_resetDisplay || display.value == 'Error') return;
    
    if (display.value.length > 1) {
      display.value = display.value.substring(0, display.value.length - 1);
      if (display.value == '-' || display.value == '-0') {
        display.value = '0';
      }
    } else {
      display.value = '0';
    }
  }

  void onDecimal() {
    if (display.value == 'Error') onClear();
    
    if (_resetDisplay) {
      display.value = '0.';
      _resetDisplay = false;
    } else if (!display.value.contains('.')) {
      display.value += '.';
    }
  }

  void onToggleSign() {
    if (display.value == '0' || display.value == '0.' || display.value == 'Error') return;
    
    if (display.value.startsWith('-')) {
      display.value = display.value.substring(1);
    } else {
      display.value = '-${display.value}';
    }
  }
  
  void onPercentage() {
    if (display.value == 'Error') return;
    
    double val = double.parse(display.value);
    val = val / 100;
    display.value = _formatNumber(val);
    _resetDisplay = true;
  }

  String _formatNumber(double number) {
    if (number.isNaN || number.isInfinite) return 'Error';
    
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    
    String str = number.toString();
    if (str.length > 10) {
      // Use exponential form for very large/small numbers or just trim
      String formatted = number.toStringAsPrecision(8);
      if (formatted.contains('.')) {
        formatted = formatted.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
      }
      return formatted;
    }
    return str;
  }
}
