import '../../models/quantity_type.dart';
import '../../models/unit.dart';

abstract class ConverterStrategy {
  QuantityType getType();

  List<Unit> getUnits();

  double convert(double value, Unit from, Unit to);
}
