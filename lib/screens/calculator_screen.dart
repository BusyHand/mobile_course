import 'package:flutter/material.dart';

import '../models/operation_type.dart';
import '../services/calculator_service.dart';
import '../services/di.dart';
import '../widgets/calc_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final calculatorService = CalculatorService(buildOperationMap());

  double? oldValue;
  OperationType? operation;
  bool isEnteringNewNumber = false;
  final String ERROR_MESSAGE = 'Error';
  final String ZERO = '0';
  String display = '0';

  void onNumber(String value) {
    setState(() {
      if (display == ERROR_MESSAGE || isEnteringNewNumber) {
        display = value;
        isEnteringNewNumber = false;
        return;
      }

      if (display == ZERO) {
        if (value == ZERO) return;

        display = value;
        return;
      }

      display += value;
    });
  }

  void onOperation(OperationType op) {
    if (display.isEmpty || display == ERROR_MESSAGE) return;

    setState(() {
      oldValue = double.parse(display);
      operation = op;
      isEnteringNewNumber = true;
    });
  }

  void onEquals() {
    try {
      if (oldValue == null || operation == null || display.isEmpty) return;

      final newValue = double.parse(display);
      final result = calculatorService.calculate(
        oldValue!,
        newValue,
        operation!,
      );

      setState(() {
        display = formatResult(result);
        oldValue = null;
        operation = null;
        isEnteringNewNumber = true;
      });
    } catch (e) {
      setState(() {
        display = ERROR_MESSAGE;
        isEnteringNewNumber = true;
      });
    }
  }

  String formatResult(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void onClear() {
    setState(() {
      display = ZERO;
      oldValue = null;
      operation = null;
      isEnteringNewNumber = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Container(
            height: 120,
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              display.isEmpty ? '0' : display,
              style: const TextStyle(fontSize: 32),
            ),
          ),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...['7', '8', '9', '4', '5', '6', '1', '2', '3', '0'].map(
                (n) => CalcButton(
                  text: n,
                  color: Colors.blue,
                  onPressed: () => onNumber(n),
                ),
              ),
              CalcButton(
                text: '+',
                color: Colors.orange,
                onPressed: () => onOperation(OperationType.add),
              ),
              CalcButton(
                text: '-',
                color: Colors.orange,
                onPressed: () => onOperation(OperationType.subtract),
              ),
              CalcButton(
                text: '*',
                color: Colors.orange,
                onPressed: () => onOperation(OperationType.multiply),
              ),
              CalcButton(
                text: '/',
                color: Colors.orange,
                onPressed: () => onOperation(OperationType.divide),
              ),
              CalcButton(
                text: '^',
                color: Colors.orange,
                onPressed: () => onOperation(OperationType.power),
              ),
              CalcButton(text: '=', color: Colors.green, onPressed: onEquals),
              CalcButton(text: 'C', color: Colors.red, onPressed: onClear),
            ],
          ),
        ],
      ),
    );
  }
}
