import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/provider/favorite_provider.dart';
import 'package:provider/provider.dart';

Size? size;

class SingleProduct extends StatefulWidget {
  final productImage;
  final productId;
  final productCategory;
  final productRate;
  // final productFavorite;
  final productOldPrice;
  final productDescription;
  final productPrice;
  final productName;
  final Function()? onTap;

  const SingleProduct(
      {required this.productImage,
      required this.productCategory,
      // required this.productFavorite,
      required this.productOldPrice,
      required this.productDescription,
      required this.productRate,
      required this.productId,
      required this.productPrice,
      required this.productName,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isFavorite = value.get("productFavorite");
                    }),
                  }
              }
          },
        );

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(12),
            alignment: Alignment.topRight,
            height: size!.height * 0.285,
            width: size!.width / 2 - 20,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productImage),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              highlightColor: Colors.greenAccent,
              splashColor: AppColors.VBlack,
              splashRadius: 2000,
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;

                  if (isFavorite == true) {
                    favoriteProvider.favorite(
                      productId: widget.productId,
                      protuctCategory: widget.productCategory,
                      productName: widget.productName,
                      productRate: widget.productRate,
                      productPrice: widget.productPrice,
                      productOldPrice: widget.productOldPrice,
                      productFavorite: true,
                      productImage: widget.productImage,
                      productDescription: widget.productDescription,
                    );
                  } else if (isFavorite == false) {
                    favoriteProvider.deleteFavorite(
                        productId: widget.productId);
                  }
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.pink[800],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.productName,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                "\$${widget.productPrice}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
