import 'package:flutter_application_1/bindings/home_bindings.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/news_detail_screen.dart';
import 'package:flutter_application_1/screens/splash_screen.dart';
import 'package:flutter_application_1/screens/topic_selection_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page:  () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page:  () => HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page:  () => NewsDetailScreen(),
    ),
    GetPage(
      name: _Paths.TOPIC_SELECTION,
      page:  () => TopicSelectionScreen(),
    ),
  ];
}