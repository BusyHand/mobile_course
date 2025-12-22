import '../../models/operation_type.dart';

abstract class CalculatorOperation {
  OperationType getOperation();

  double execute(double oldValue, double newValue);
}
