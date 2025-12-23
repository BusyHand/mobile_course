import '../../models/quantity_type.dart';
import '../../models/unit.dart';
import 'converter_strategy.dart';

class LengthConverter implements ConverterStrategy {
  final Map<String, double> factors = {'cm': 0.01, 'm': 1.0, 'km': 1000.0};

  @override
  QuantityType getType() => QuantityType.length;

  @override
  List<Unit> getUnits() => [
    Unit('Centimeter', 'cm'),
    Unit('Meter', 'm'),
    Unit('Kilometer', 'km'),
  ];

  @override
  double convert(double value, Unit from, Unit to) {
    return value * factors[from.symbol]! / factors[to.symbol]!;
  }
}
