import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/pages/Details/details_page.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/single_product.dart';

class GridViewWidget extends StatelessWidget {
  final String id;
  final String collection;
  final String subCollection;

  const GridViewWidget(
      {required this.id,
      required this.collection,
      required this.subCollection,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collection)
            .doc(id)
            .collection(subCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
              snapshot.data!.docs.isEmpty
                  ? Text("No Favorites Selected Yet")
                  : GridView.builder(
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
                          productId: data["productId"],
                          productCategory: data["productCategory"],
                          productOldPrice: data["productOldPrice"],
                          productRate: data["productRate"],
                          productImage: data["productImage"],
                          productName: data["productName"],
                          productPrice: data["productPrice"],
                          productDescription: data["productDescription"],
                          onTap: () {
                            RoutingPage.goTonext(
                              context: context,
                              navigateTo: DetailsPage(
                                productCategory: data["productCategory"],
                                productId: data["productId"],
                                productImage: data["productImage"],
                                productName: data["productName"],
                                productDescription: data["productDescription"],
                                productOldPrice: data["productOldPrice"],
                                productPrice: data["productPrice"],
                                productRate: data["productRate"],
                              ),
                            );
                          },
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
