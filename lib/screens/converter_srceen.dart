import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  String formatResult(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value
        .toStringAsFixed(4)
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll('.', '.');
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // INPUT
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
              onChanged: (v) => setState(() => input = v),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28),
              decoration: const InputDecoration(
                hintText: '0',
                border: InputBorder.none,
              ),
            ),

            const SizedBox(height: 32),

            // FROM
            DropdownButton<Unit>(
              value: from,
              items: strategy
                  .getUnits()
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.symbol)))
                  .toList(),
              onChanged: (v) => setState(() => from = v!),
            ),
            IconButton(icon: const Icon(Icons.swap_vert), onPressed: swap),

            // TO
            DropdownButton<Unit>(
              value: to,
              items: strategy
                  .getUnits()
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.symbol)))
                  .toList(),
              onChanged: (v) => setState(() => to = v!),
            ),

            const SizedBox(height: 24),
            if (result != null)
              Text(
                'Result: ${formatResult(result)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
