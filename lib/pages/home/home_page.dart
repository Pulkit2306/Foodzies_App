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
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .snapshots(),
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
                                collection: streamSnap.data!.docs[index]
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
          Container(
            height: 300,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
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
                      return SingleProduct(
                        image: streamSnap.data!.docs[index]["productImage"],
                        name: streamSnap.data!.docs[index]["productName"],
                        price: streamSnap.data!.docs[index]["productPrice"],
                        onTap: () {
                          RoutingPage.goTonext(
                              context: context, 
                              navigateTo: DetailsPage(),
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
          Container(
            height: 300,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("products")
                  .where("productRate", isLessThanOrEqualTo: 3)
                  .orderBy(
                    "productRate",
                    descending: true,
                  )
                  .snapshots(),
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
                      return SingleProduct(
                        image: streamSnap.data!.docs[index]["productImage"],
                        name: streamSnap.data!.docs[index]["productName"],
                        price: streamSnap.data!.docs[index]["productPrice"],
                        onTap: () {
                          RoutingPage.goTonext(
                              context: context, 
                              navigateTo: DetailsPage(),
                              );
                        },
                        // onTap: RoutingPage.goTonext(
                        //   context: context,
                        //   navigateTo: DetailsPage(),
                        //  ),
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
