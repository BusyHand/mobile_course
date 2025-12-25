import 'package:flutter/material.dart';

import '../models/quantity_type.dart';
import 'converter_srceen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Converter')),
      body: ListView(
        children: QuantityType.values.map((type) {
          return ListTile(
            title: Text(type.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ConverterScreen(type: type)),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
