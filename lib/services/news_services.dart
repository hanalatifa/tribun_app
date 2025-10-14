import 'dart:convert';
import 'package:flutter_application_1/models/news_response.dart';
import 'package:flutter_application_1/utils/constants.dart';
// mendefiniskan langsung sebuah package atau library djadi sebuah variable secara langsung
import 'package:http/http.dart' as http;

class NewsService {
  static const String _baseUrl = Constants.baseUrl;
  static final String _apiKey = Constants.apiKey;

  // Fungsi yang bertujuan untuk membuat request GET ke server
  Future<NewsResponse> getTopHeadlines({
    String country = Constants.defaultCountry,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'country': country,
        'page': page.toString(),
        'pageSize': pageSize.toString()
      };

      // Statement yang akan dijalankan ketika category tidak kosong
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }

      // berfungsi untuk parsing data dari json ke ui
      final uri = Uri.parse('$_baseUrl${Constants.topHeadLines}');
      // e = error

      // untuk menyimpan respon yang di berikan oleh server
      final response = await http.get(uri);

      // kode yang akan dijalankan jika request ke API succesess
      if (response.statusCode == 200) {
        // untuk merubah data dari json ke bahasa dart
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
        // kode yang akan di jalan jika req ke API gagal atau status error
      } else {
        throw Exception('failed to load news, please try again later');
      }

      // jika code di jalankan ketika error lain selain yang sudah dibuat diatas
    } catch (e) {
      throw Exception('Another problem occurs, please try again later');
    }
  }
  Future<NewsResponse> searchNews({
    required String query, //ini adalah nilai yang di masukkan ke kolom pencarian
    int page = 1,// ini untuk mendefiniskan halaman berita ke berapa
    int pageSize = 20, // ini berita yang ingin di tampilkan ketika sekali proseses rendering data
    String? sortBy,
  }) async{
    try {
      final Map<String,String> queryParams = {
        'apiKey':_apiKey,
        'q' : query,
        'page' : page.toString(),
        'pageSize': pageSize.toString(),
      };

      if(sortBy != null && sortBy.isNotEmpty){
        queryParams['sortBy'] =sortBy;
      }

      final uri = Uri.parse('$_baseUrl${Constants.everything}')
                  .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('failed to load news, please try again later');
      }
    } catch (e) {
      throw Exception('Another problem occurs, please try again later');
    }
  }
}