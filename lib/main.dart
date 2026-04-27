import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/about/about_screen.dart';
import 'package:my_flutter_mini_project/presentations/myInfo/myInfo_screen.dart';
import 'package:my_flutter_mini_project/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import './core/routes/app_routes.dart';
import 'presentations/home/home_screen.dart';

void main() {
  runApp(const TripApp());
}

class TripApp extends StatelessWidget {
  const TripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TripProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // 테마 정보
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        ),
        // 앱 전역 라우팅 정보
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.about: (context) => AboutScreen(),
          AppRoutes.myInfo: (context) => MyInfoScreen(),
        },
      ),
    );
  }
}
