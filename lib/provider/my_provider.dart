import 'package:FoodNewApp/model/cart_model.dart';
import 'package:FoodNewApp/model/categories_model.dart';
import 'package:FoodNewApp/model/food_categories_model.dart';
import 'package:FoodNewApp/model/foods_model.dart';
import 'package:FoodNewApp/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {
  List<CategoriesModle> burgerList =[];
  CategoriesModle burgerModel;
  Future<void> getBurger() async {
    List<CategoriesModle> newburgerList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('e97ioNQ8KBtxd3hsshAk')
        .collection('Burger')
        .get();
    querySnapshot.docs.forEach((element) {
      burgerModel = CategoriesModle(
          image: element.data()['image'],
          name: element.data()['name'],
      );
      // print(burgerModel.name);
      newburgerList.add(burgerModel);
      burgerList = newburgerList;
      notifyListeners();
    });
    // notifyListeners();
  }
  get throwBurger{
    return burgerList;
  }
  ////////////// 2 categories //////////////
  List<CategoriesModle> coffeList =[];
  CategoriesModle coffeModel;
  Future<void> getCoffeCategory() async {
    List<CategoriesModle> newCoffeList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('e97ioNQ8KBtxd3hsshAk')
        .collection('Coffe')
        .get();
    querySnapshot.docs.forEach((element) {
      coffeModel = CategoriesModle(
        image: element.data()['image'],
        name: element.data()['name'],
      );
      // print(coffeModel.name);
      newCoffeList.add(coffeModel);
      coffeList = newCoffeList;
    });
    // notifyListeners();
  }
  get throwCoffeList {
    return coffeList;
  }
  ////////3nd categories //////////
  List<CategoriesModle> drinkList =[];
  CategoriesModle drinkModel;
  Future<void> getDrinkCategory() async {
    List<CategoriesModle> newDrinkList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('e97ioNQ8KBtxd3hsshAk')
        .collection('Drink')
        .get();
    querySnapshot.docs.forEach((element) {
      drinkModel = CategoriesModle(
        image: element.data()['image'],
        name: element.data()['name'],
      );
      // print(drinkModel.name);
      newDrinkList.add(drinkModel);
      drinkList = newDrinkList;
    });
    // notifyListeners();
  }
  get throwDrinkList {
    return drinkList;
  }
  //////////4nd///////////////////
  List<CategoriesModle> pizzaList =[];
  CategoriesModle pizzaModel;
  Future<void> getPizzaCategory() async {
    List<CategoriesModle> newPizzaList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('categories')
        .doc('e97ioNQ8KBtxd3hsshAk')
        .collection('Pizza')
        .get();
    querySnapshot.docs.forEach((element) {
        pizzaModel = CategoriesModle(
        image: element.data()['image'],
        name: element.data()['name'],
      );
      // print(pizzaModel.name);
      newPizzaList.add(pizzaModel);
      pizzaList = newPizzaList;
    });
    // notifyListeners();
  }
  get throwPizzaList {
    return pizzaList;
  }

  //////////// single food Item //////////////////

  List<FoodModel> foodModelList = [];
  FoodModel foodModel;
  Future<void> getFoodList() async {
    List<FoodModel> newFoodModelList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Foods').get();
    querySnapshot.docs.forEach((element) {
      foodModel = FoodModel(
          image: element.data()['image'],
          name: element.data()['name'],
          price: element.data()['price']
      );
      // print(foodModel.name);
      newFoodModelList.add(foodModel);
      foodModelList = newFoodModelList;

    });
    // notifyListeners();
  }
  get throwFoodModelList {
    return foodModelList;
  }

  //////////// Buger category /
  List<FoodCategoriesModels> burgerCategoriesList = [];
  FoodCategoriesModels burgerCategoriesModel;
  Future<void> getBurgerCategoriesList() async {
    List<FoodCategoriesModels> newBurgerCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('VzXF3aaxOoCbQFKItDDS')
        .collection('Burger')
        .get();
    querySnapshot.docs.forEach((element) {
      burgerCategoriesModel = FoodCategoriesModels(
          name: element.data()['name'],
          price: element.data()['price'],
          image: element.data()['image']
      );
      newBurgerCategoriesList.add(burgerCategoriesModel);
      burgerCategoriesList = newBurgerCategoriesList;
    });
  }

  get throwBurgerCategoriesList {
    return burgerCategoriesList;
  }
  ///////////Coffe cattegory///////////////

  List<FoodCategoriesModels> coffeCategoriesList = [];
  FoodCategoriesModels coffeCategoriesModel;
  Future<void> getCoffeCategoriesList() async {
    List<FoodCategoriesModels> newCoffeCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('VzXF3aaxOoCbQFKItDDS')
        .collection('Coffe')
        .get();
    querySnapshot.docs.forEach((element) {
      coffeCategoriesModel = FoodCategoriesModels(
          name: element.data()['name'],
          price: element.data()['price'],
          image: element.data()['image']
      );
      newCoffeCategoriesList.add(coffeCategoriesModel);
      coffeCategoriesList = newCoffeCategoriesList;
    });
  }

  get throwCoffeCategoriesList {
    return coffeCategoriesList;
  }

  /////////// Drink category/////////////
  List<FoodCategoriesModels> drinkCategoriesList = [];
  FoodCategoriesModels drinkCategoriesModel;
  Future<void> getDrinkCategoriesList() async {
    List<FoodCategoriesModels> newDrinkCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('VzXF3aaxOoCbQFKItDDS')
        .collection('Drink')
        .get();
    querySnapshot.docs.forEach((element) {
      drinkCategoriesModel = FoodCategoriesModels(
          name: element.data()['name'],
          price: element.data()['price'],
          image: element.data()['image']
      );
      newDrinkCategoriesList.add(drinkCategoriesModel);
      drinkCategoriesList = newDrinkCategoriesList;
    });
  }

  get throwDrinkCategoriesList {
    return drinkCategoriesList;
  }
  ////////Pizza category/////
  List<FoodCategoriesModels> pizzaCategoriesList = [];
  FoodCategoriesModels pizzaCategoriesModel;
  Future<void> getPizzaCategoriesList() async {
    List<FoodCategoriesModels> newPizzaCategoriesList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('foodcategories')
        .doc('VzXF3aaxOoCbQFKItDDS')
        .collection('Pizza')
        .get();
    querySnapshot.docs.forEach((element) {
      pizzaCategoriesModel = FoodCategoriesModels(
          name: element.data()['name'],
          price: element.data()['price'],
          image: element.data()['image']
      );
      newPizzaCategoriesList.add(pizzaCategoriesModel);
      pizzaCategoriesList = newPizzaCategoriesList;
    });
  }

  get throwPizzaCategoriesList {
    return pizzaCategoriesList;
  }
  ////// add to cart //////////

  List<CartModel> cartList = [];
  List<CartModel> newCartList = [];
  CartModel cartModel;
  void addToCart({@required String image,@required String name, @required int price, @required int quantity}){
    cartModel = CartModel(
      image: image,
      name: name,
      price: price,
      quantity: quantity,
    );
    newCartList.add(cartModel);
    cartList = newCartList;
  }
  get throwCartList{
    return cartList;
  }

  int totalprice(){
    int total = 0;
    cartList.forEach((element) {
      total += element.price*element.quantity;
    });
    return total;
  }
  int deleteIndex;
  void getDeleteIndex(int index){
    deleteIndex = index;
  }
  void delete(){
    cartList.removeAt(deleteIndex);
    notifyListeners();
  }
  //
  // _getuserid() async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   final idToken = user.uid;
  //   final token = idToken.toString();
  //   print('token $user');
  // }
  /////// get infor user /////
  final userid = FirebaseAuth.instance.currentUser.uid;
  UserInforModel userInforModel;
  Future<void> getUserInfor() async {
    // _getuserid();
    // print('userid: $userid');
    DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userData').doc('$userid').get();
    userInforModel = UserInforModel(
        name: '${querySnapshot.data()['first name']} ${querySnapshot.data()['last name']}',
        address: querySnapshot.data()['address'],
        dayofbirth: querySnapshot.data()['birth'],
        email: querySnapshot.data()['email']
    );
    // notifyListeners();
    // print('object: ${userInforModel.name}');
  }

  get throwUserInfor {
    return userInforModel;
  }
}