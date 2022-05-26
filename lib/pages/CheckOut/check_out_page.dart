import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/provider/cart_provider.dart';
import 'package:food_demo_app/widgets/my_button.dart';
import 'package:food_demo_app/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    double subTotaL = cartProvider.subTotal();

    double subTotal = double.parse((subTotaL).toStringAsFixed(2));

    double discount = 7.5;

    double shipping = 2.5;

    double discountValue = (subTotal * discount) / 100;

    double value = subTotal - discountValue;

    double shippingValue = (discountValue * shipping) / 100;

    double finalValuE = value += shippingValue;
    
    double finalValue = double.parse((finalValuE).toStringAsFixed(2));

    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        finalValue = 0.0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "CHECK OUT",
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
            child: cartProvider.getCartList.isEmpty
                ? Center(
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
                    }),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  leading: Text("Sub Total"),
                  trailing: Text("\$ $subTotal"),
                ),
                ListTile(
                  leading: Text("Discount"),
                  trailing: Text("7.5%"),
                ),
                ListTile(
                  leading: Text("Delivery Charges"),
                  trailing: Text("\2.5%"),
                ),
                Divider(
                  thickness: 2,
                ),
                ListTile(
                  leading: Text("Total"),
                  trailing: Text("\$ $finalValue"),
                ),
                cartProvider.getCartList.isEmpty
                    ? Text("")
                    : MyButton(onPressed: () {}, text: "Order Now"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
