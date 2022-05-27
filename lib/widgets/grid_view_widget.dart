import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/pages/Details/details_page.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/single_product.dart';

class GridViewWidget extends StatefulWidget {
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
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  String query = "";
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["productName"].toUpperCase().contains(query) ||
          element["productName"].toLowerCase().contains(query) ||
          element["productName"].toUpperCase().contains(query) &&
              element["productName"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.collection)
            .doc(widget.id)
            .collection(widget.subCollection)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var varData = searchFunction(query, snapshot.data!.docs);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  elevation: 7,
                  shadowColor: Colors.grey[300],
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
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
              result.isEmpty
                  ? Center(child: Text("Not Found"))
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: result.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (ctx, index) {
                        var data = varData[index];
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
                      }),
            ],
          );
        },
      ),
    );
  }
}
