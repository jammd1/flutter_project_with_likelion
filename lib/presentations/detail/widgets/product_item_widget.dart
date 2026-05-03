import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:my_flutter_mini_project/presentations/detail/widgets/product_detail_dialog_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final TripDestination destination;
  final int idx;
  const ProductItemWidget(this.idx, this.destination, {super.key});

  void _showProductDialog(BuildContext context, int idx) {
    showDialog(context: context, builder: (BuildContext context) {
      return ProductDetailDialogWidget(destination, idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: Image.network(
          destination.imagePath,
          width: 60,
            height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey,
              child: Icon(Icons.broken_image, color: Colors.grey),
            );
          },
        ),
      ),
      title: Text('${destination.name} 여행 상품 ${idx + 1}'),
      subtitle: Text('${(idx + 1) * 100} 만원 부터'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        _showProductDialog(context, idx);
      },
    );
  }
}
