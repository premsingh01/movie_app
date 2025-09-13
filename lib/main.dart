import 'package:flutter/material.dart';
import 'package:movie_app/core/database/app_database.dart';
import 'package:movie_app/feature/dashboard/presentation/page/dashboard_view.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDatabase.instance.database;
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 26, 26, 26),
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          color: const Color.fromARGB(255, 26, 26, 26),
          actionsPadding: const EdgeInsets.only(right: 10),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      home: DashboardView(),
    );
  }
}
