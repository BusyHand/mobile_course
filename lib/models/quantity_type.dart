enum QuantityType {
  length('Длина'),
  weight('Вес'),
  temperature('Температура'),
  area('Площадь'),
  currency('Валюта');

  final String title;

  const QuantityType(this.title);
}
