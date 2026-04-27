import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_drawer_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_grid_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_middle_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_top_widget.dart';
import 'package:my_flutter_mini_project/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tripy'),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert)),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      drawer: HomeDrawerWidget(),
      body: Column(
        children: [
          // 홈 상단 위젯 - 구성 요소: 여행 광고
          HomeTopWidget(),

          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                children: [
                  // 홈 중단 위젯 - 구성 요소: 버튼
                  HomeMiddleWidget(),
                  SizedBox(height: 16),
                  Expanded(
                    child: Consumer<TripProvider>(
                      builder: (ctx, provider, child) {
                        return HomeGridWidget(
                          destinations: provider.destination,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
