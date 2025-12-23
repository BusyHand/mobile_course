import '../../models/quantity_type.dart';
import '../../models/unit.dart';
import 'converter_strategy.dart';

class TemperatureConverter implements ConverterStrategy {
  @override
  QuantityType getType() => QuantityType.temperature;

  @override
  List<Unit> getUnits() => [
    Unit('Celsius', 'C'),
    Unit('Fahrenheit', 'F'),
    Unit('Kelvin', 'K'),
  ];

  @override
  double convert(double value, Unit from, Unit to) {
    if (from.symbol == to.symbol) return value;

    double celsius;
    switch (from.symbol) {
      case 'F':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'K':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    switch (to.symbol) {
      case 'F':
        return celsius * 9 / 5 + 32;
      case 'K':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }
}
