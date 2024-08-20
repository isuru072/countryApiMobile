import 'package:dio/dio.dart';
import 'package:european_countries_app/models/country_model.dart';
import 'package:european_countries_app/services/country_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Dio])
void main() {
  group('CountryService', () {
    late MockDio mockDio;
    late CountryService countryService;

    setUp(() {
      mockDio = MockDio();
      countryService = CountryService(dio: mockDio);
    });

    test('fetchCountries returns a list of CountryModel', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: ''),
        data: [
          {
            "name": {"common": "Norway", "official": "Kingdom of Norway"},
            "capital": ["Oslo"],
            "region": "Europe",
            "languages": {"nno": "Norwegian Nynorsk"},
            "population": 5379475,
            "flags": {
              "png": "https://flagcdn.com/w320/no.png",
              "svg": 'https://flagcdn.com/gr.svg"',
              "alt":
                  'The flag of Greece is composed of nine equal horizontal bands of blue alternating with white. A blue square bearing a white cross is superimposed in the canton.'
            }
          }
        ],
        statusCode: 200,
      );

      final countries = await countryService.fetchCountries();

      expect(countries, isA<List<CountryModel>>());
      expect(countries.first.name.common, 'Norway');
    });

    test('fetchCountries handles error response', () async {
      when(mockDio.get(any.toString())).thenThrow(DioError(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 404,
        ),
        type: DioExceptionType.badResponse,
      ));

      expect(() => countryService.fetchCountries(), throwsException);
    });
  });
}

class MockDio extends Mock implements Dio {}
