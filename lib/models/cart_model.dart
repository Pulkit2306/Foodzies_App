import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productId;
  final String productImage;
  final String productTitle;
  final double productPrice;
  final int productQuantity;
  final String productCategory;

  CartModel({
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.productQuantity,
    required this.productCategory,
    required this.productPrice,
  });
  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productId: doc["productId"],
      productImage: doc["productImage"],
      productTitle: doc["productName"],
      productPrice: doc["productPrice"],
      productQuantity: doc["productQuantity"],
      productCategory: doc["productCategory"],
    );
  }
}
