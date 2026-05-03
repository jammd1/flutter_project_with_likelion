import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';

class HomeGridItemWidget extends StatelessWidget {
  final TripDestination destination;
  final int? idx;



  const HomeGridItemWidget({super.key, required this.destination, required this.idx});
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          color: Theme.of(context).cardColor,
          child: Container(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Image.network(
                      destination.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: Icon(Icons.broken_image, color: Colors.red, size: 40,),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                    )
                ),
                Text(
                  destination.name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  destination.discount,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 12,
                      fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: -4,
          top: -10,
          child: Stack(
            children: [
              Icon(
                Icons.circle,
                color: Colors.lightBlueAccent,
                size: 50
              ),
              Positioned(
                left: idx! > 9 ? 13:18,
                top: 10,
                child: Text(
                  idx.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20
                  ),

                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
