import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/home/home_page.dart';
import 'package:food_demo_app/pages/login/login_page.dart';
import 'package:food_demo_app/pages/profile/profile_page.dart';
import 'package:food_demo_app/route/routing_page.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({ Key? key }) : super(key: key);

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
            leading: IconButton( onPressed: (){
              RoutingPage.goTonext(
                context: context, 
                navigateTo: ProfilePage(),
                );
            },
              icon: Icon(
                Icons.person,
              ),
              ),
            title: Text('Profile'),
            ),

          ListTile(
            leading: IconButton( onPressed: (){},
              icon: Icon(
                Icons.shopping_cart_sharp,
              ),
              ),
            title: Text('Your Cart'),
            ),



          ListTile(
            leading: IconButton( onPressed: (){},
              icon: Icon(
                Icons.favorite,
              ),
              ),
            title: Text('Favorite'),
            ),

            ListTile(
            leading: IconButton( onPressed: (){},
              icon: Icon(
                Icons.shopping_basket_sharp,
              ),
              ),
            title: Text('My Order'),
            ),

            ListTile(
              leading: IconButton(onPressed: () { 
                    FirebaseAuth.instance.signOut().then(
                    (value) => RoutingPage.goTonext(
                      context: context,
                      navigateTo: LoginPage(),
                    ),
                  );
               }, 
              icon: Icon(
                Icons.logout_outlined
                ),
              ),
              title: Text("Log Out"),
            ),
        ],
      ),
    );
  }
}