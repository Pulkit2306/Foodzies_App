import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/widgets/single_product.dart';

class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;

  const GridViewWidget({required this.id, required this.collection, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("categories")
            .doc(id)
            .collection(collection)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Material(
                  elevation: 7,
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search_sharp),
                      fillColor: AppColors.KWhite,
                      filled: true,
                      hintText: "Search Your Poduct",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  return SingleProduct(
                    image: data["productImage"],
                    name: data["productName"],
                    price: data["productPrice"],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
