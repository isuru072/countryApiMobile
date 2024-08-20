import 'package:european_countries_app/models/country_model.dart';
import 'package:european_countries_app/services/country_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countryServiceProvider = Provider<CountryService>((ref) {
  return CountryService();
});

final sortCriteriaProvider = StateProvider<SortCriteria>((ref) {
  return SortCriteria.name;
});

enum SortCriteria { name, capital, population }

List<CountryModel> sortCountries(
    List<CountryModel> countries, SortCriteria value) {
  // Switch statement to handle different sorting value
  switch (value) {
    // Sort by country name.
    case SortCriteria.name:
      // Compare country names for alphabetical sorting.
      countries
          .sort((a, b) => a.name.common.compareTo(b.name.common.toString()));
      break;

    // Sort by capital city.
    case SortCriteria.capital:
      countries.sort((a, b) {
        // Get the first capital city or an empty string if the list is empty.
        final aCapital = a.capital.isNotEmpty ? a.capital.first : '';
        final bCapital = b.capital.isNotEmpty ? b.capital.first : '';
        // Compare capital cities for alphabetical sorting.
        return aCapital.compareTo(bCapital);
      });
      break;

    // Sort by population.
    case SortCriteria.population:
      countries.sort((a, b) => a.population.compareTo(b.population as num));
      break;
  }

  // Return the sorted list of countries.
  return countries;
}

final countriesProvider = FutureProvider<List<CountryModel>>((ref) async {
  final apiService = CountryService();
  try {
    return await apiService.fetchCountries();
  } catch (e) {
    rethrow;
  }
});
