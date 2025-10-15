import 'package:flutter_application_1/models/news_articles.dart';
import 'package:flutter_application_1/services/news_services.dart';
import 'package:flutter_application_1/utils/constants.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService(); // untuk memproses request yang sudah dibuat oleh NewsServices

  // Setter
  // observalble variables (variable yang bisa berubah)
  final _isLoading = false.obs; // apaka aplikasi yang sedang memuat berita? (true/false)
  final _articles = <NewsArticles>[].obs; // unutk menampilkan daftar berita 
  final _selectedCategory = 'general'.obs; // unutk handle kategori yang sedang dipilih (yang akan muncul di screen)
  final _error = ''.obs; // kalau ada kesalahan pesan error akan disimpan disini

  // Getters
  // getter ini, seperti jendela untuk melihat isi varibale yang sudah didefinisikan
  // dengan ini, UI bisa dnegan mudah melihat data dari controller

  bool get isLoading => _isLoading.value;
  List<NewsArticles> get articles => _articles;
  String get selectedCategory => _selectedCategory.value;
  String get error => _error.value;
  List<String> get categories => Constants.categories;

  // begitu aplikasi dibuka, aplikasi langsung menampilkan berita utama dari endpoint top-headlines
  // TODO: Fatching data dari endpoint top-headlines

  Future<void> fetchTopHeadLines({String? category})async {
    // blok ini akan dijalankan ketika req ke API berhasil
    try {
      _isLoading.value = true;
      _error.value = "";

      final response = await _newsService.getTopHeadlines(
        category: category ?? _selectedCategory.value,
      );

      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      // finally akan tetap diexcuted setelah salah satu dari blok try atau catch sudah berhasil mendapatkan hasil
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    await fetchTopHeadLines();
  }

  void selectedCategorys(String category) {
    if (_selectedCategory.value != category) {
      _selectedCategory.value = category;
      fetchTopHeadLines(category: category);
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _newsService.searchNews(query: query);
      _articles.value = response.articles;
    } catch (e) {
      _error.value =e.toString();
      Get.snackbar(
        'Error',
        'Failed to search news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM
      );
    } finally {
      _isLoading.value = false;
    }
  }
}