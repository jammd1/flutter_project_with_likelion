import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';

class HomeGridItemWidget extends StatelessWidget {
  final TripDestination destination;



  const HomeGridItemWidget({super.key, required this.destination});
  @override
  Widget build(BuildContext context) {
    RegExp regExp = RegExp(r'(\d+\.?\d*)%');
    final match = regExp.firstMatch(destination.discount);
    final String? discountString = match?.group(0);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(4),
          ),
          color: Colors.white,
          child: Container(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Image.asset(
                      destination.imagePath,
                      fit: BoxFit.cover,
                    )
                ),
                Text(
                  destination.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  destination.discount,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: -7,
          top: -6,
          child: Stack(
            children: [
              Icon(
                Icons.pentagon,
                color: Colors.lightBlueAccent,
                size: 50
              ),
              Positioned(
                top: 15,
                left: 8,
                child: Text(
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                  ),
                  '-${discountString!}'
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
