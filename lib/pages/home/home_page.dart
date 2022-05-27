import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/appColors/app_colors.dart';
import 'package:food_demo_app/models/user_model.dart';
import 'package:food_demo_app/pages/Details/details_page.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/build_drawer.dart';
import 'package:food_demo_app/widgets/grid_view_widget.dart';

import '../../widgets/single_product.dart';

late UserModel userModel;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future getCurrentUserDataFunction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userModel = UserModel.fromDocument(documentSnapshot);
      } else {
        print("Document does not exist");
      }
    });
  }

  Widget buildCategory() {
    return Column(
      children: [
        ListTile(
          leading: Text(
            "Categories",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: Colors.grey[500],
            ),
          ),
        ),
        Container(
          height: 125,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("categories").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
              if (!streamSnap.hasData) {
                return Center(child: const CircularProgressIndicator());
              }
              // return Container(
              //   color: Colors.red,
              // );
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: streamSnap.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    return Categories(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GridViewWidget(
                              collection: "categories",
                              subCollection: streamSnap.data!.docs[index]
                                  ["categoryName"],
                              id: streamSnap.data!.docs[index].id,
                            ),
                          ),
                        );
                      },
                      categoryName: streamSnap.data!.docs[index]
                          ["categoryName"],
                      image: streamSnap.data!.docs[index]["categoryImage"],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget buildProduct(
      {required Stream<QuerySnapshot<Map<String, dynamic>>>? stream}) {
    return Container(
      height: 300,
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
          if (!streamSnap.hasData) {
            return Center(child: const CircularProgressIndicator());
          }
          // return Container(
          //   color: Colors.red,
          // );
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemCount: streamSnap.data!.docs.length,
              itemBuilder: (ctx, index) {
                var varData = searchFunction(query, streamSnap.data!.docs);

                var data = varData[index];

                // var data = streamSnap.data!.docs[index];
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
                // return Categories(
                //   onTap: () {

                //   },
                //   categoryName: streamSnap.data!.docs[index]
                //       ["categoryName"],
                //   image: streamSnap.data!.docs[index]["categoryImage"],
                // );
              });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserDataFunction();
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          SizedBox(
            height: 30,
          ),
          query == ""
              ? Column(
                  children: [
                    buildCategory(),

                    // SingleChildScrollView(
                    //   physics: BouncingScrollPhysics(),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Categories(
                    //         categoryName: "Category 1",
                    //         image: "Assets/Images/starters.jpg",
                    //       ),
                    //       Categories(
                    //         categoryName: "Catergory 2",
                    //         image: "Assets/Images/soup.webp",
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.purpleAccent[500],
                        ),
                      ),
                    ),
                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Text(
                        "Best Seller",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.indigo[500],
                        ),
                      ),
                    ),

                    buildProduct(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .where("productRate", isLessThanOrEqualTo: 3)
                          .orderBy(
                            "productRate",
                            descending: true,
                          )
                          .snapshots(),
                    ),
                  ],
                )
              : Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnap) {
                      if (!streamSnap.hasData) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      // return Container(
                      //   color: Colors.red,
                      // );

                      var varData =
                          searchFunction(query, streamSnap.data!.docs);
                      return result.isEmpty
                          ? Center(child: Text("Not Found"))
                          : GridView.builder(
                            shrinkWrap: true,
                              itemCount: result.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                  productDescription:
                                      data["productDescription"],
                                  onTap: () {
                                    RoutingPage.goTonext(
                                      context: context,
                                      navigateTo: DetailsPage(
                                        productCategory:
                                            data["productCategory"],
                                        productId: data["productId"],
                                        productImage: data["productImage"],
                                        productName: data["productName"],
                                        productDescription:
                                            data["productDescription"],
                                        productOldPrice:
                                            data["productOldPrice"],
                                        productPrice: data["productPrice"],
                                        productRate: data["productRate"],
                                      ),
                                    );
                                  },
                                );
                              });

                      // return ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     physics: BouncingScrollPhysics(),
                      //     itemCount: streamSnap.data!.docs.length,
                      //     itemBuilder: (ctx, index) {
                      //       var varData =
                      //           searchFunction(query, streamSnap.data!.docs);

                      //       var data = varData[index];

                      //       // var data = streamSnap.data!.docs[index];
                      //       return SingleProduct(
                      //         productId: data["productId"],
                      //         productCategory: data["productCategory"],
                      //         productOldPrice: data["productOldPrice"],
                      //         productRate: data["productRate"],
                      //         productImage: data["productImage"],
                      //         productName: data["productName"],
                      //         productPrice: data["productPrice"],
                      //         productDescription: data["productDescription"],
                      //         onTap: () {
                      //           RoutingPage.goTonext(
                      //             context: context,
                      //             navigateTo: DetailsPage(
                      //               productCategory: data["productCategory"],
                      //               productId: data["productId"],
                      //               productImage: data["productImage"],
                      //               productName: data["productName"],
                      //               productDescription:
                      //                   data["productDescription"],
                      //               productOldPrice: data["productOldPrice"],
                      //               productPrice: data["productPrice"],
                      //               productRate: data["productRate"],
                      //             ),
                      //           );
                      //         },
                      //       );
                      //       // return Categories(
                      //       //   onTap: () {

                      //       //   },
                      //       //   categoryName: streamSnap.data!.docs[index]
                      //       //       ["categoryName"],
                      //       //   image: streamSnap.data!.docs[index]["categoryImage"],
                      //       // );
                      //     });
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final Function()? onTap;

  const Categories({
    Key? key,
    required this.image,
    required this.categoryName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12),
        height: 100,
        width: 185,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              image,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.center,
              colors: [
                Colors.black.withOpacity(0.55),
                Colors.grey.withOpacity(0.7),
              ],
            ),
          ),
          child: Center(
            child: Text(
              categoryName,
              style: TextStyle(
                color: AppColors.KWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
