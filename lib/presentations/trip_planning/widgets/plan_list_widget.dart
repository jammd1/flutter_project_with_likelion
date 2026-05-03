import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_plan.dart';
import 'package:my_flutter_mini_project/providers/trip_planning_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PlanListWidget extends StatefulWidget {
  const PlanListWidget({super.key});

  @override
  State<PlanListWidget> createState() => _PlanListWidgetState();
}

class _PlanListWidgetState extends State<PlanListWidget> {
  @override
  void initState() {
    super.initState();
  }

  Icon _categoryIcon(String category) {
    switch (category) {
      case '명소':
        return Icon(Icons.photo_camera, color: Colors.lightBlueAccent);
      case '음식':
        return Icon(Icons.restaurant, color: Colors.orange);
      case '호텔':
        return Icon(Icons.hotel, color: Colors.purple);
      case '이동수단':
        return Icon(Icons.directions_transit, color: Colors.green);
      default:
        return Icon(Icons.place, color: Colors.grey);
    }
  }

  Future<void> _openMap(String place) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(place)}',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripPlanningProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (provider.plans.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.luggage, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  '저장된 일정이 없습니다',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: provider.plans.length,
          itemBuilder: (context, index) {
            final plan = provider.plans[index];
            return Dismissible(
              key: Key(plan.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => provider.deletePlan(plan.id),
              child: _PlanCard(plan: plan, categoryIcon: _categoryIcon, onOpenMap: _openMap),
            );
          },
        );
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  final TripPlan plan;
  final Icon Function(String) categoryIcon;
  final Future<void> Function(String) onOpenMap;

  const _PlanCard({
    required this.plan,
    required this.categoryIcon,
    required this.onOpenMap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          plan.title,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.flight_takeoff, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(plan.destination, style: TextStyle(color: Colors.grey)),
                SizedBox(width: 12),
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(plan.createdAt, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 6),
            Wrap(
              spacing: 6,
              children: [
                _Tag(plan.companion),
                _Tag(plan.style),
                ...plan.foodPrefs.map((f) => _Tag(f)),
              ],
            ),
          ],
        ),
        children: plan.schedule.map((dayPlan) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(height: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text(
                  '${dayPlan.day}일차',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
              ...dayPlan.activities.map((activity) {
                return ListTile(
                  dense: true,
                  leading: categoryIcon(activity.category),
                  title: Row(
                    children: [
                      Text(
                        activity.time,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          activity.place,
                          style: TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    activity.description,
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.map_outlined, size: 20),
                    onPressed: () => onOpenMap(activity.place),
                  ),
                );
              }),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: Colors.lightBlueAccent),
      ),
    );
  }
}
