import 'package:european_countries_app/models/country_model.dart';
import 'package:european_countries_app/providers/provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Country Sorting', () {
    late List<CountryModel> countries;
    Map<String, dynamic> jsonData = {
      "fra": "French",
    };
    setUp(() {
      countries = [
        CountryModel(
          name: Name(common: 'France', official: '', nativeName: {}),
          population: 67000000,
          capital: ['Paris'],
          flags: Flags(
              png: "https://flagcdn.com/w320/fr.png",
              svg: "https://flagcdn.com/fr.svg",
              alt:
                  "The flag of France is composed of three equal vertical bands of blue, white and red."),
          region: '',
          languages: Languages.fromJson(jsonData),
        ),
      ];
    });

    test('sort countries by name', () {
      final sorted = sortCountries(countries, SortCriteria.name);
      expect(sorted.first.name.common, 'France');

      expect(jsonData["fra"], "French");
    });
  });
}
