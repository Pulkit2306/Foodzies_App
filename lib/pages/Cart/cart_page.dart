import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/widgets/my_button.dart';
import 'package:food_demo_app/widgets/single_cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyButton(onPressed: () {}, text: "Check Out"),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("cart")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("userCart")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
            if (!streamSnap.hasData) {
              return Center(child: const CircularProgressIndicator());
            }
            // return Container(
            //   color: Colors.red,
            // );
            return ListView.builder(
                
                physics: BouncingScrollPhysics(),
                itemCount: streamSnap.data!.docs.length,
                itemBuilder: (ctx, index) {
                  var data = streamSnap.data!.docs[index];
                  return SingleCartItem(
                    productImage: data["productImage"],
                    productTitle: data["productName"],
                    productPrice: data["productPrice"],
                    productQuantity: data["productQuantity"],
                  );
                });
          }),
    );
  }
}
