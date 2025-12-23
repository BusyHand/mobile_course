import '../models/quantity_type.dart';
import 'strategies/converter_strategy.dart';
import 'strategies/length_converter.dart';
import 'strategies/weight_converter.dart';
import 'strategies/temperature_converter.dart';
import 'strategies/area_converter.dart';
import 'strategies/currency_converter.dart';

Map<QuantityType, ConverterStrategy> buildConverterMap() {
  final strategies = <ConverterStrategy>[
    LengthConverter(),
    WeightConverter(),
    TemperatureConverter(),
    AreaConverter(),
    CurrencyConverter(),
  ];

  return {
    for (var s in strategies) s.getType(): s
  };
}