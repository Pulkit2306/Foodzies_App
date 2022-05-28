import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  void favorite(
      {required productId,
      required protuctCategory,
      required productName,
      required productRate,
      required productPrice,
      required productOldPrice,
      required productFavorite,
      required productImage,
      
      I}) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(productId)
        .set(
      {
        "productId": productId,
        "productName": productName,
        "productOldPrice": productOldPrice,
        "productPrice": productPrice,
        "productImage": productImage,
        "protuctCategory": protuctCategory,
        "productRate": productRate,
        "productFavorite": productFavorite,
      },
    );
  }

  deleteFavorite({
    required String productId,
  }) {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavorite")
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
