import '../../models/quantity_type.dart';
import '../../models/unit.dart';
import 'converter_strategy.dart';

class AreaConverter implements ConverterStrategy {
  final Map<String, double> factors = {'m2': 1, 'km2': 1000000, 'ha': 10000};

  @override
  QuantityType getType() => QuantityType.area;

  @override
  List<Unit> getUnits() => [
    Unit('Square meter', 'm2'),
    Unit('Square kilometer', 'km2'),
    Unit('Hectare', 'ha'),
  ];

  @override
  double convert(double value, Unit from, Unit to) {
    return value * factors[from.symbol]! / factors[to.symbol]!;
  }
}
