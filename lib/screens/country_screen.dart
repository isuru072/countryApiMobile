import 'package:european_countries_app/models/country_model.dart';
import 'package:european_countries_app/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final CountryModel country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF7FFFFFF),
      appBar: CustomAppBar(title: country.name.common.toString()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag Image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  country.flags.png.toString(),
                  width: MediaQuery.sizeOf(context).width / 1.5,
                  height: MediaQuery.sizeOf(context).width / 2.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Body Content
            Text(
              'Official Name: ${country.name.official}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            Text(
              'Capital: ${country.capital.first}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),

            Text(
              'Region: ${country.region}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),

            Text(
              'Population: ${country.population.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8.0),

            Text(
              'Languages: ${country.languages.languages.values.join(', ')}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
