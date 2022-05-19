import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/Details/Components/bottom_part.dart';
import 'package:food_demo_app/pages/Details/Components/top_part.dart';

class DetailsPage extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productDescription;
  final double productPrice;
  final double productOldPrice;
  final int productRate;
  final String productId;

  const DetailsPage({
    Key? key,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productOldPrice,
    required this.productRate,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPart(
              productImage: productImage,
            ),
            BottomPart(
              productImage: productImage,
              productId: productId,
              productName: productName,
              productOldPrice: productOldPrice,
              productPrice: productPrice,
              productRate: productRate,
              productDescription: productDescription,
            ),
          ],
        ),
      ),
    );
  }
}
