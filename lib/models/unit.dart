class Unit {
  final String name;
  final String symbol;

  Unit(this.name, this.symbol);

  @override
  String toString() => symbol;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Unit && symbol == other.symbol;

  @override
  int get hashCode => symbol.hashCode;
}
