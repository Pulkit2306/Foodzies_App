// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_demo_app/pages/home/home_page.dart';
import 'package:food_demo_app/pages/login/components/login_auth_provider.dart';
import 'package:food_demo_app/route/routing_page.dart';
import 'package:food_demo_app/widgets/my_button.dart';

class ProfilePage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(LoginAuthProvider.pattern.toString());

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;

  TextEditingController fullName =
      TextEditingController(text: userModel.fullName);
  TextEditingController emailAddress =
      TextEditingController(text: userModel.emailAddress);
  TextEditingController contactNumber =
      TextEditingController(text: userModel.contactNumber);

  void profilePageValidation({
    required TextEditingController? emailAddress,
    required TextEditingController? fullName,
    required TextEditingController? contactNumber,
    required BuildContext context,
  }) async {
    if (fullName!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Provide a Name.")),
      );
      return;
    } else if (emailAddress!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please provide your Email Address.")),
      );
      return;
    } else if (!widget.regExp.hasMatch(emailAddress.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email address.")),
      );
      return;
    } else if (contactNumber!.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Enter a Phone Number.")),
      );
      return;
    } else {
      buildUpdateProfile();
    }
  }

  Widget textFormField({required String hintText}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: ListTile(
        leading: Text(hintText),
      ),
    );
  }

  Widget nonEditTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("Assets/Images/logo.jpeg"),
              radius: 50,
            ),
          ],
        ),
        SizedBox(
          height: 70,
        ),
        textFormField(
          hintText: userModel.fullName,
        ),
        SizedBox(
          height: 30,
        ),
        textFormField(
          hintText: userModel.emailAddress,
        ),
        SizedBox(
          height: 30,
        ),
        textFormField(
          hintText: userModel.contactNumber,
        ),
      ],
    );
  }

  Widget editTextField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("Assets/Images/logo.jpeg"),
              radius: 50,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          controller: fullName,
          decoration: InputDecoration(
            hintText: 'Full Name',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: contactNumber,
          decoration: InputDecoration(
            hintText: 'Contact Number',
          ),
        ),
        SizedBox(
          height: 50,
        ),
        MyButton(
            onPressed: () {
              profilePageValidation(
                context: context,
                emailAddress: emailAddress, 
                fullName: fullName, 
                contactNumber: contactNumber,                                               
              );
              
            },
            text: "Update Information")
      ],
    );
  }

  Future buildUpdateProfile() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        "FullName": fullName.text,
        "emailAddress": emailAddress.text,
        "Contact": contactNumber.text,
      },
    ).then(
      (value) => RoutingPage.goTonext(
        context: context,
        navigateTo: HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = false;
                  });
                },
                icon: Icon(Icons.close))
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: isEdit ? editTextField() : nonEditTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
