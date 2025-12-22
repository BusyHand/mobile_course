import '../../models/operation_type.dart';
import 'calculator_operation.dart';

class MultiplyOperation implements CalculatorOperation {
  @override
  OperationType getOperation() => OperationType.multiply;

  @override
  double execute(double oldValue, double newValue) {
    return oldValue * newValue;
  }
}


