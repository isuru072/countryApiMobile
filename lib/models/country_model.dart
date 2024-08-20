class CountryModel {
  final Flags flags;
  final Name name;
  final List<String> capital;
  final String region;
  final Languages languages;
  final int population;

  CountryModel({
    required this.flags,
    required this.name,
    required this.capital,
    required this.region,
    required this.languages,
    required this.population,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      flags: Flags.fromJson(json['flags']),
      name: Name.fromJson(json['name']),
      capital: List<String>.from(json['capital']),
      region: json['region'],
      languages: Languages.fromJson(json['languages']),
      population: json['population'],
    );
  }
}

class Flags {
  final String png;
  final String svg;
  final String alt;

  Flags({
    required this.png,
    required this.svg,
    required this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      png: json['png'],
      svg: json['svg'],
      alt: json['alt'],
    );
  }
}

class Name {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      common: json['common'],
      official: json['official'],
      nativeName: (json['nativeName'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, NativeName.fromJson(value))),
    );
  }
}

class NativeName {
  final String official;
  final String common;

  NativeName({
    required this.official,
    required this.common,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) {
    return NativeName(
      official: json['official'],
      common: json['common'],
    );
  }
}

class Languages {
  final Map<String, String> languages;

  Languages({required this.languages});

  factory Languages.fromJson(Map<String, dynamic> json) {
    return Languages(
      languages: (json as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value ?? '')),
    );
  }
}
