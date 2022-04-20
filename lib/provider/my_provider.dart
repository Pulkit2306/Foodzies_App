import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:food_demo_app/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_demo_app/models/food_modle.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModel> burgerList = [];
  late CategoriesModel burgerModel;
  Future<void> getBurgerCategory() async {
    List<CategoriesModel> newBurgerList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ChGOkOuQKR1RPNNlMTgR')
        .collection('Burger')
        .get();
    querySnapshot.docs.forEach((element) {
      burgerModel = CategoriesModel(
        image: element['image'],
        name: element['name'],
      );

      newBurgerList.add(burgerModel);
      burgerList = newBurgerList;
    });
    notifyListeners();
  }

  get throwBurgerList {
    return burgerList;
  }

  List<CategoriesModel> recipeList = [];
  late CategoriesModel recipeModel;
  Future<void> getRecipeCategory() async {
    List<CategoriesModel> newRecipeList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ChGOkOuQKR1RPNNlMTgR')
        .collection('Recipe')
        .get();
    querySnapshot.docs.forEach((element) {
      recipeModel = CategoriesModel(
        image: element['image'],
        name: element['name'],
      );
      print(recipeModel.name);
      newRecipeList.add(recipeModel);
      recipeList = newRecipeList;
    });
    notifyListeners();
  }

  get throwRecipeList {
    return recipeList;
  }

  List<CategoriesModel> pizzaList = [];
  late CategoriesModel pizzaModel;
  Future<void> getpizzaCategory() async {
    List<CategoriesModel> newPizzaList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ChGOkOuQKR1RPNNlMTgR')
        .collection('Pizzas')
        .get();
    querySnapshot.docs.forEach((element) {
      pizzaModel = CategoriesModel(
        image: element['image'],
        name: element['name'],
      );
      print(pizzaModel.name);
      newPizzaList.add(pizzaModel);
      pizzaList = newPizzaList;
    });
    notifyListeners();
  }

  get throwPizzaList {
    return pizzaList;
  }

  List<CategoriesModel> drinksList = [];
  late CategoriesModel drinksModel;
  Future<void> getDrinksCategory() async {
    List<CategoriesModel> newDrinksList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('ChGOkOuQKR1RPNNlMTgR')
        .collection('Drinks')
        .get();
    querySnapshot.docs.forEach((element) {
      drinksModel = CategoriesModel(
        image: element['image'],
        name: element['name'],
      );
      print(drinksModel.name);
      newDrinksList.add(drinksModel);
      drinksList = newDrinksList;
    });
    notifyListeners();
  }

  get throwDrinksList {
    return drinksList;
  }

  List<FoodModle> foodModleList = [];
  late FoodModle foodModle;
  Future<void> getFoodList() async {
    List<FoodModle> newFoodModleList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Foods').get();
    querySnapshot.docs.forEach((element) {
      foodModle = FoodModle(
        image: element['image'],
        name: element['name'],
        price: element['price'],
      );
    });

    newFoodModleList.add(foodModle);
    foodModleList = newFoodModleList;
  }

  get throwFoodModlelist {
    return foodModleList;
  }
}
