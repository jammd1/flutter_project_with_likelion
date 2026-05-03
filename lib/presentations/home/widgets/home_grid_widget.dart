import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/core/routes/app_routes.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_grid_item_widget.dart';

class HomeGridWidget extends StatelessWidget {
  final List<TripDestination> destinations;

  const HomeGridWidget({super.key, required this.destinations,});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      padding: EdgeInsetsGeometry.only(top: 12),
      itemCount: destinations.length,
      itemBuilder: (context, idx) {
        final destination = destinations[idx];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.detail, arguments: destination);
          },
          child: HomeGridItemWidget(destination: destination, idx:  idx + 1,)
        );
      },
    );
  }
}
