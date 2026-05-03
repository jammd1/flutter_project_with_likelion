import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:my_flutter_mini_project/presentations/detail/widgets/product_item_widget.dart';

class ProductListWidget extends StatelessWidget {
  final TripDestination destination;

  const ProductListWidget(this.destination, {super.key});



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.network(
                destination.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            destination.description,
            style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(height: 24),
          Text(
            '추천 상품',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, idx) {
              return Card(
                margin: EdgeInsetsGeometry.only(bottom: 12),
                
                child: ProductItemWidget(idx, destination),
              );
            },
          ),
        ],
      ),
    );
  }
}
