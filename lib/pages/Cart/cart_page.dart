// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/CheckOut/check_out_page.dart';
import 'package:food_demo_app/provider/cart_provider.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/my_button.dart';
import 'package:food_demo_app/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty? 
      Center(
        child: Text(
          "Cart Is Empty! Check Out Our Amazing Food And Put It in The Cart Here......", 
          style: TextStyle(fontSize: 20, ), 
          textAlign: TextAlign.center,
          ),
      ) : MyButton(
          onPressed: () {
            RoutingPage.goTonext(
              context: context,
              navigateTo: CheckOutPage(),
            );
          },
          text: "Check Out"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: 
      cartProvider.getCartList.isEmpty? 
      Center(
        child: Text(
          "Cart list is empty"
          ),
      )
      
      : ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: cartProvider.getCartList.length,
          itemBuilder: (ctx, index) {
            var data = cartProvider.cartList[index];
            return SingleCartItem(
              productId: data.productId,
              productImage: data.productImage,
              productTitle: data.productTitle,
              productPrice: data.productPrice,
              productQuantity: data.productQuantity,
              productCategory: data.productCategory,
            );
          }
          ),
    );
  }
}
