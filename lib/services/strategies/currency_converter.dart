import '../../models/quantity_type.dart';
import '../../models/unit.dart';
import 'converter_strategy.dart';

class CurrencyConverter implements ConverterStrategy {
  final Map<String, double> rates = {'USD': 1, 'EUR': 0.9, 'RUB': 90};

  @override
  QuantityType getType() => QuantityType.currency;

  @override
  List<Unit> getUnits() => [
    Unit('US Dollar', 'USD'),
    Unit('Euro', 'EUR'),
    Unit('Ruble', 'RUB'),
  ];

  @override
  double convert(double value, Unit from, Unit to) {
    return value / rates[from.symbol]! * rates[to.symbol]!;
  }
}
