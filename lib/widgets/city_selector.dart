import 'package:flutter/material.dart';

import '../models/city.dart';

class CitySelector extends StatelessWidget {
  final List<City> cities;
  final City selectedCity;
  final Function(City) onCitySelected;

  const CitySelector({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите город',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          ...cities.map((city) {
            return ListTile(
              leading: Icon(
                Icons.location_city,
                color: isDark ? Colors.blue[200] : Colors.blue,
              ),
              title: Text(
                city.name,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              trailing: city.name == selectedCity.name
                  ? Icon(
                Icons.check,
                color: isDark ? Colors.blue[200] : Colors.blue,
              )
                  : null,
              tileColor: isDark ? Colors.grey[800] : Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () {
                onCitySelected(city);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}