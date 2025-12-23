import 'package:mobile_course/services/strategies/converter_strategy.dart';

import '../models/quantity_type.dart';

class ConverterService {
  final Map<QuantityType, ConverterStrategy> strategies;

  ConverterService(this.strategies);

  ConverterStrategy getStrategy(QuantityType type) {
    return strategies[type]!;
  }
}
