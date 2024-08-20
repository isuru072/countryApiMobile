import 'package:european_countries_app/helper/validation.dart';
import 'package:european_countries_app/providers/provider.dart';
import 'package:european_countries_app/screens/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final countryAsyncValue = ref.watch(countriesProvider);
    final sortCriteria = ref.watch(sortCriteriaProvider);

    return Column(
      children: [
        //Search dropdown
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                  child: DropdownButton<SortCriteria>(
                    value: sortCriteria,
                    onChanged: (SortCriteria? newValue) {
                      ref.read(sortCriteriaProvider.notifier).state = newValue!;
                    },
                    items: SortCriteria.values.map((SortCriteria criteria) {
                      return DropdownMenuItem<SortCriteria>(
                        value: criteria,
                        child: Text(capitalizeFirstLetter(criteria.name)),
                      );
                    }).toList(),
                    underline: const SizedBox(),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ],
          ),
        ),
        // List view for viewing countries
        Expanded(
            child: countryAsyncValue.when(
                data: (countries) {
                  if (countries.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }
                  final sortedCountries =
                      sortCountries(countries, sortCriteria);
                  return ListView.builder(
                    itemCount: sortedCountries.length,
                    itemBuilder: (context, index) {
                      final country = sortedCountries[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          leading: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 4,
                              ),
                            ], borderRadius: BorderRadius.circular(4.0)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                country.flags.png.toString(),
                                width: 100.0,
                                height: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            country.name.common.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(country.capital.first),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CountryDetailScreen(country: country),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) {
                  // Show a toast message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error: ${error.toString()}"),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 4),
                    ),
                  );

                  return Center(
                    child: Text(
                      'Error: ${error.toString()}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                })),
      ],
    );
  }
}
