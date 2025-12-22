import 'operations/calculator_operation.dart';
import 'operations/add_operation.dart';
import 'operations/subtract_operation.dart';
import 'operations/multiply_operation.dart';
import 'operations/divide_operation.dart';
import 'operations/power_operation.dart';
import '../models/operation_type.dart';

Map<OperationType, CalculatorOperation> buildOperationMap() {
  final List<CalculatorOperation> operations = [
    AddOperation(),
    SubtractOperation(),
    MultiplyOperation(),
    DivideOperation(),
    PowerOperation(),
  ];

  return {
    for (var op in operations) op.getOperation(): op
  };
}
