// A brand news for make a screen using get state management

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/controllers/news_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<NewsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          )
        ],
      ),
    );
  }
void _showSearchDialog(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
  }
  
}