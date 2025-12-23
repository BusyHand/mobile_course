import 'package:flutter/material.dart';

import '../models/quantity_type.dart';
import '../models/unit.dart';
import '../services/converter_service.dart';
import '../services/di.dart';
import '../services/strategies/converter_strategy.dart';

class ConverterScreen extends StatefulWidget {
  final QuantityType type;

  const ConverterScreen({super.key, required this.type});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final service = ConverterService(buildConverterMap());

  late ConverterStrategy strategy;
  late Unit from;
  late Unit to;
  String input = '';

  @override
  void initState() {
    super.initState();
    strategy = service.getStrategy(widget.type);
    from = strategy.getUnits().first;
    to = strategy.getUnits()[1];
  }

  void swap() {
    setState(() {
      final temp = from;
      from = to;
      to = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double? result;
    if (input.isNotEmpty) {
      result = strategy.convert(double.parse(input), from, to);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.type.name)),
      body: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => setState(() => input = v),
          ),
          DropdownButton<Unit>(
            value: from,
            items: strategy
                .getUnits()
                .map((u) => DropdownMenuItem(value: u, child: Text(u.symbol)))
                .toList(),
            onChanged: (v) => setState(() => from = v!),
          ),
          IconButton(icon: const Icon(Icons.swap_vert), onPressed: swap),
          DropdownButton<Unit>(
            value: to,
            items: strategy
                .getUnits()
                .map((u) => DropdownMenuItem(value: u, child: Text(u.symbol)))
                .toList(),
            onChanged: (v) => setState(() => to = v!),
          ),
          if (result != null) Text('Result: $result'),
        ],
      ),
    );
  }
}
