import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showCountriesDialog(context) => showAdaptiveDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('United States'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('United Kingdom'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Canada'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Australia'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );

Future<List<Country>> loadCountries() async {
  final String response = await rootBundle.loadString('assets/json/countries.json');
  final List countries = await jsonDecode(response);
  final result = countries.map((country) => Country.fromJson(country)).toList();
  return result;
}

final class Country {
  final String name;
  final String code;
  final String phone;
  final dynamic phoneLength;

  Country({
    required this.name,
    required this.code,
    required this.phone,
    required this.phoneLength,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      code: json['code'],
      phone: json['phone'],
      phoneLength: json['phoneLength'],
    );
  }
}
