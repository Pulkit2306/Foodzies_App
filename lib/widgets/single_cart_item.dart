import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';

class SingleCartItem extends StatefulWidget {
  final String productImage;
  final String productTitle;
  final double productPrice;
  final int productQuantity;
  final String productCategory;
  final String productId;

  const SingleCartItem({
    Key? key,
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productQuantity,
    required this.productCategory,
  }) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int quantity = 1;

  void quantityFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({
      "productQuantity": quantity,
    });
  }

  void deleteProductFunction() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 7),
        ],
        // image: DecorationImage(
        //   image: AssetImage("Assets/Images/logo.jpeg"),
        // ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.productImage),
                    ),
                  ),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.productTitle,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widget.productCategory,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "\$${widget.productPrice * widget.productQuantity}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IncrementAndDecrement(
                            onPressed: () {
                              setState(() {
                                quantity++;
                                quantityFunction();
                              });
                            },
                            icon: Icons.add,
                          ),
                          // SizedBox(width: 25,),
                          Text(
                            widget.productQuantity.toString(),
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          IncrementAndDecrement(
                            onPressed: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  quantityFunction();
                                });
                              }
                            },
                            icon: Icons.remove,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              deleteProductFunction();
            },
            icon: Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

class IncrementAndDecrement extends StatelessWidget {
  final Function()? onPressed;
  final IconData icon;

  const IncrementAndDecrement({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40,
      height: 30,
      elevation: 2,
      onPressed: onPressed,
      color: AppColors.KGradient1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: AppColors.KWhite,
      ),
    );
  }
}
