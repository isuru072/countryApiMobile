import 'package:european_countries_app/helper/validation.dart';
import 'package:european_countries_app/providers/provider.dart';
import 'package:european_countries_app/screens/country_screen.dart';
import 'package:european_countries_app/screens/home.dart';
import 'package:european_countries_app/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: 'European Countries',
      home: const CountryListScreen(),
    );
  }
}

class CountryListScreen extends ConsumerWidget {
  const CountryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
        backgroundColor: Color(0xF7FFFFFF),
        appBar: CustomAppBar(
          title: 'European Countries',
        ),
        body: Home());
  }
}
