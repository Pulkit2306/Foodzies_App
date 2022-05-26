import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/Cart/cart_page.dart';
import 'package:food_demo_app/pages/CheckOut/check_out_page.dart';
import 'package:food_demo_app/pages/favourites/favourite_page.dart';
import 'package:food_demo_app/pages/home/home_page.dart';
import 'package:food_demo_app/pages/login/login_page.dart';
import 'package:food_demo_app/pages/profile/profile_page.dart';
import 'package:food_demo_app/route/routing_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            accountName: Text(userModel.fullName),
            accountEmail: Text(userModel.emailAddress),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("Assets/Images/logo.jpeg"),
            ),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: ProfilePage(),
              );
            },
            leading: Icon(
              Icons.person,
            ),
            title: Text('Profile'),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: CartPage(),
              );
            },
            leading: Icon(
              Icons.shopping_cart_sharp,
            ),
            title: Text('Your Cart'),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: FavouritePage(),
              );
            },
            leading: Icon(
              Icons.favorite,
            ),
            title: Text('Favorite'),
          ),
          ListTile(
            onTap: () {
              RoutingPage.goTonext(
                context: context,
                navigateTo: CheckOutPage(),
              );
            },
            leading: Icon(
              Icons.shopping_basket_sharp,
            ),
            title: Text('My Order'),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => RoutingPage.goTonext(
                      context: context,
                      navigateTo: LoginPage(),
                    ),
                  );
            },
            leading: Icon(Icons.logout_outlined),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
