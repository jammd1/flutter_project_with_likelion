import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/core/routes/app_routes.dart';
import 'package:my_flutter_mini_project/presentations/trip_planning/widgets/create_plan_widget.dart';
import 'package:my_flutter_mini_project/presentations/trip_planning/widgets/plan_list_widget.dart';


class TripPlanningScreen extends StatefulWidget {
  const TripPlanningScreen({super.key});

  @override
  State<TripPlanningScreen> createState() => _TripPlanningScreenState();
  
}

class _TripPlanningScreenState extends State<TripPlanningScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {

    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI 여행 계획'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (r) => false);
          }, icon: Icon(Icons.home))
        ],

        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.lightBlueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.lightBlueAccent,
          tabs: [
            Tab(text: '새 일정'),
            Tab(text: '내 일정'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
            CreatePlanWidget(),
            PlanListWidget()
          ]
      ),
    );
  }
}