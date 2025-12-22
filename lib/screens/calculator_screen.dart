import 'package:flutter/material.dart';
import '../services/calculator_service.dart';
import '../services/di.dart';
import '../models/operation_type.dart';
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
  String display = '';

  void onNumber(String value) {
    setState(() {
      display += value;
    });
  }

  void onOperation(OperationType op) {
    setState(() {
      oldValue = double.parse(display);
      display = '';
      operation = op;
    });
  }

  void onEquals() {
    try {
      final newValue = double.parse(display);
      final result = calculatorService.calculate(
        oldValue!,
        newValue,
        operation!,
      );
      setState(() {
        display = result.toString();
      });
    } catch (e) {
      setState(() {
        display = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Text(display, style: const TextStyle(fontSize: 32)),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...['7','8','9','4','5','6','1','2','3','0']
                  .map((n) => CalcButton(
                text: n,
                color: Colors.blue,
                onPressed: () => onNumber(n),
              )),
              CalcButton(text: '+', color: Colors.orange, onPressed: () => onOperation(OperationType.add)),
              CalcButton(text: '-', color: Colors.orange, onPressed: () => onOperation(OperationType.subtract)),
              CalcButton(text: '*', color: Colors.orange, onPressed: () => onOperation(OperationType.multiply)),
              CalcButton(text: '/', color: Colors.orange, onPressed: () => onOperation(OperationType.divide)),
              CalcButton(text: '^', color: Colors.orange, onPressed: () => onOperation(OperationType.power)),
              CalcButton(text: '=', color: Colors.green, onPressed: onEquals),
            ],
          ),
        ],
      ),
    );
  }
}
