import '../../models/quantity_type.dart';
import '../../models/unit.dart';
import 'converter_strategy.dart';

class WeightConverter implements ConverterStrategy {
  final Map<String, double> factors = {'g': 1, 'kg': 1000, 't': 1000000};

  @override
  QuantityType getType() => QuantityType.weight;

  @override
  List<Unit> getUnits() => [
    Unit('Gram', 'g'),
    Unit('Kilogram', 'kg'),
    Unit('Ton', 't'),
  ];

  @override
  double convert(double value, Unit from, Unit to) {
    return value * factors[from.symbol]! / factors[to.symbol]!;
  }
}
