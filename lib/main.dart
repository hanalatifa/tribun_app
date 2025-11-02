import 'package:flutter/material.dart';
import 'package:flutter_application_1/bindings/app_bindings.dart';
import 'package:flutter_application_1/routes/app_pages.dart';
import 'package:flutter_application_1/utils/app_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void main() async {
  runApp(TribunApp());
  WidgetsFlutterBinding.ensureInitialized();

  // load environment variables first before running the app
  await dotenv.load(fileName: '.env');
}

class TribunApp extends StatelessWidget {
  const TribunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tribun App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          ),
        ),
 
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
    );
  }
}