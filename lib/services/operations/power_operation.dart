import '../../models/operation_type.dart';
import 'calculator_operation.dart';

import 'dart:math';

class PowerOperation implements CalculatorOperation {
  @override
  OperationType getOperation() => OperationType.power;

  @override
  double execute(double oldValue, double newValue) {
    return pow(oldValue, newValue).toDouble();
  }
}

