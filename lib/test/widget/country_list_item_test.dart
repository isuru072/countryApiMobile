import 'package:european_countries_app/models/country_model.dart';
import 'package:european_countries_app/screens/country_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CountryListItem displays country details',
      (WidgetTester tester) async {
    Map<String, dynamic> jsonData = {
      "languages": {"nno": "Norwegian Nynorsk"},
    };
    final country = CountryModel(
      name: Name(common: 'Norway', official: '', nativeName: {}),
      capital: ['Oslo'],
      flags: Flags(
          png: 'https://flagcdn.com/w320/no.png',
          svg: 'https://flagcdn.com/gr.svg"',
          alt:
              'The flag of Greece is composed of nine equal horizontal bands of blue alternating with white. A blue square bearing a white cross is superimposed in the canton.'),
      population: 5379475,
      region: '"Europe"',
      languages: Languages.fromJson(jsonData),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CountryDetailScreen(country: country),
        ),
      ),
    );

    expect(find.text('Norway'), findsOneWidget);
    expect(find.text('Oslo'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
