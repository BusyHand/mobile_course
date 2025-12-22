import '../models/operation_type.dart';
import 'operations/calculator_operation.dart';

class CalculatorService {
  final Map<OperationType, CalculatorOperation> operationMap;

  CalculatorService(this.operationMap);

  double calculate(
      double oldValue,
      double newValue,
      OperationType operation,
      ) {
    final strategy = operationMap[operation];
    if (strategy == null) {
      throw Exception('Operation not supported');
    }
    return strategy.execute(oldValue, newValue);
  }
}
