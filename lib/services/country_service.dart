import 'package:dio/dio.dart';
import 'package:european_countries_app/models/country_model.dart';

class CountryService {
  final Dio _dio = Dio();
  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await _dio.get(
          'https://restcountries.com/v3.1/region/europe?fields=name,capital,flags,region,languages,population');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((json) => CountryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
