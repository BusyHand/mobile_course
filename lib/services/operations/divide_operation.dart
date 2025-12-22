import '../../models/operation_type.dart';
import 'calculator_operation.dart';

class DivideOperation implements CalculatorOperation {
  @override
  OperationType getOperation() => OperationType.divide;

  @override
  double execute(double oldValue, double newValue) {
    if (newValue == 0) {
      throw Exception('Division by zero');
    }
    return oldValue / newValue;
  }
}


