import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/pages/Cart/cart_page.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/my_button.dart';

class BottomPart extends StatelessWidget {
  final String productName;
  final String productImage;
  final double productPrice;
  final String productDescription;
  final double productOldPrice;
  final int productRate;
  final String productId;

  const BottomPart({
    Key? key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productDescription,
    required this.productOldPrice,
    required this.productRate,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Text(
                "\$$productPrice",
                style: TextStyle(),
              ),
              SizedBox(
                width: 7.5,
              ),
              Text(
                "\$$productOldPrice",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Divider(
                thickness: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.KGradient2,
                    ),
                    child: Center(
                      child: Text(
                        productRate.toString(),
                        style: TextStyle(
                          color: AppColors.KWhite,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Reviews",
                    style: TextStyle(
                      color: AppColors.KGradient2,
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
            ],
          ),
          Text(
            "About the Dish",
            style: TextStyle(
              color: AppColors.KGradient1,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(productDescription),
          MyButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("cart")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("userCart")
                  .doc(productId)
                  .set(
                {
                  "productId": productId,
                  "productImage": productImage,
                  "productName": productName,
                  "productRate": productRate,
                  "productPrice": productPrice,
                  "productOldPrice": productOldPrice,
                  "productDescription": productDescription,
                  "productQuantity": 1,
                },
              );
              RoutingPage.goTonext(
                context: context,
                navigateTo: CartPage(),
              );
            },
            text: "Add To Cart",
          ),
        ],
      ),
    );
  }
}
