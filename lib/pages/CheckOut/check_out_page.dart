import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/provider/cart_provider.dart';
import 'package:food_demo_app/widgets/my_button.dart';
import 'package:food_demo_app/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("CHECK OUT",
        style: TextStyle(
          fontSize: 17,
          color: AppColors.VBlack,
        ),
        
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: cartProvider.getCartList.isEmpty? 
      Center(
        child: Text(
          "Aren't You Going To Place An Order?",
          style: TextStyle(
            fontSize: 18,
          ),
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
            ),
            Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: Text("Sub Total"),
                  trailing: Text("\$12"),
                ),
                ListTile(
                  leading: Text("Discount"),
                  trailing: Text("5%"),
                ),
                ListTile(
                  leading: Text("Delivery Charges"),
                  trailing: Text("\$2"),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Text("Total"),
                  trailing: Text("\$13"),
                ),
                cartProvider.getCartList.isEmpty? Text("") : MyButton(
                  onPressed: (){}, 
                text: "Order Now"
                ),
              ],
            ), 
            ),
        ],
        ),
    );
  }
}
