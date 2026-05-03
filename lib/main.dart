import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/core/theme/app_theme.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:my_flutter_mini_project/presentations/about/about_screen.dart';
import 'package:my_flutter_mini_project/presentations/home/all_destination_screen.dart';
import 'package:my_flutter_mini_project/presentations/detail/detail_screen.dart';
import 'package:my_flutter_mini_project/presentations/my_info/my_info_screen.dart';
import 'package:my_flutter_mini_project/presentations/trip_planning/trip_planning_screen.dart';
import 'package:my_flutter_mini_project/providers/news_provider.dart';
import 'package:my_flutter_mini_project/providers/search_history_provider.dart';
import 'package:my_flutter_mini_project/providers/theme_provider.dart';
import 'package:my_flutter_mini_project/providers/trip_planning_provider.dart';
import 'package:my_flutter_mini_project/providers/trip_provider.dart';
import 'package:my_flutter_mini_project/providers/user_info_provider.dart';
import 'package:my_flutter_mini_project/services/destination_service.dart';
import 'package:my_flutter_mini_project/services/news_service.dart';
import 'package:my_flutter_mini_project/services/search_history_storage_service.dart';
import 'package:my_flutter_mini_project/services/trip_planning_service.dart';
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
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..load()),
        ChangeNotifierProvider(
          create: (_) => TripProvider(DestinationService.instance)..getDestinations(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserInfoProvider()..loadUserInfo(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              SearchHistoryProvider(SearchHistoryStorageService.instance)
                ..loadHistory(),
          child: HomeScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TripPlanningProvider(TripPlanningService.instance)..loadPlans(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            initialRoute: AppRoutes.home,
            routes: {
              AppRoutes.home: (context) => HomeScreen(),
              AppRoutes.about: (context) => AboutScreen(),
              AppRoutes.myInfo: (context) => MyInfoScreen(),
              AppRoutes.all: (context) => AllDestinationScreen(),
              AppRoutes.plan: (context) => TripPlanningScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == AppRoutes.detail) {
                final destination = settings.arguments as TripDestination;
                return MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => NewsProvider(NewsService.instance),
                    child: DetailScreen(destination),
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
