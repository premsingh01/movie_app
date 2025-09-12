import 'package:flutter/material.dart';
import 'package:movie_app/feature/dashboard/presentation/page/dashboard_view.dart';
import 'service_locator.dart' as di;

void main() {
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
        useMaterial3: true,
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
