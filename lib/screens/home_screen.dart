import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/news_controller.dart';
import 'package:flutter_application_1/routes/app_pages.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_application_1/widgets/category_chip.dart';
import 'package:flutter_application_1/widgets/loading_shimmer.dart';
import 'package:flutter_application_1/widgets/news_card.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris atas: NewsFeed + Icon Notifikasi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'NewsFeed',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.notifications_none, color: Colors.black, size: 28),
                ],
              ),
               SizedBox(height: 24),

              // Teks besar Discover Breaking News
               Text(
                'Discover Breaking News',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 16),

              // Kotak Search
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child:  TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search all news',
                    border: InputBorder.none,
                  ),
                ),
              ),

               SizedBox(height: 20),

              // Categories (dari code kamu)
              // Container(
              //   height: 60,
              //   color: Colors.white,
              //   child: ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     itemCount: controller.categories.length,
              //     itemBuilder: (context, index) {
              //       final category = controller.categories[index];
              //       return Obx(() => CategoryChip(
              //             label: category.capitalize ?? category,
              //             isSelected: controller.selectedCategory == category,
              //             onTap: () => controller.selectCategory(category),
              //           ));
              //     },
              //   ),
              // ),

              // List Berita
              Expanded(
                child: Obx(() {
                  if (controller.isLoading) return LoadingShimmer();
                  if (controller.error.isNotEmpty) return _buildErrorWidget();
                  if (controller.articles.isEmpty) return _buildEmptyWidget();

                  return RefreshIndicator(
                    onRefresh: controller.refreshNews,
                    child: ListView.builder(
                      padding:  EdgeInsets.all(16),
                      itemCount: controller.articles.length,
                      itemBuilder: (context, index) {
                        final article = controller.articles[index];
                        return NewsCard(
                          articles: article,
                          onTap: () => Get.toNamed(
                            Routes.NEWS_DETAIL,
                            arguments: article,
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),

              Container(
                decoration:  BoxDecoration(
                  color: Color(0xFFF5F5F5), 
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:  BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor:  Color(0xFFF5F5F5),
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items:  <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        activeIcon: Icon(Icons.home),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.explore_outlined),
                        activeIcon: Icon(Icons.explore),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.bookmark_border),
                        activeIcon: Icon(Icons.bookmark),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        activeIcon: Icon(Icons.person),
                        label: '',
                      ),
                    ],
                    currentIndex: 0,
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black54,
                    onTap: (index) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: AppColors.error),
          SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please check your internet connection',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.refreshNews,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper, size: 64, color: AppColors.textHint),
          SizedBox(height: 16),
          Text(
            'No news available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please try again later',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search News'),
        content: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Enter search term...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              controller.searchNews(value);
              Navigator.of(context).pop();
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (searchController.text.isNotEmpty) {
                controller.searchNews(searchController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }
}
