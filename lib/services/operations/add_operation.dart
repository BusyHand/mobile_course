import '../../models/operation_type.dart';
import 'calculator_operation.dart';

class AddOperation implements CalculatorOperation {
  @override
  OperationType getOperation() => OperationType.add;

  @override
  double execute(double oldValue, double newValue) {
    return oldValue + newValue;
  }
}
