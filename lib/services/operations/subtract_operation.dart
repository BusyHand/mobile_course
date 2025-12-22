import '../../models/operation_type.dart';
import 'calculator_operation.dart';

class SubtractOperation implements CalculatorOperation {
  @override
  OperationType getOperation() => OperationType.subtract;

  @override
  double execute(double oldValue, double newValue) {
    return oldValue - newValue;
  }
}

