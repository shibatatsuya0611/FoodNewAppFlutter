import 'package:flutter/cupertino.dart';

class CartModel{
  final String image;
  final String name;
  final int price;
  final int quantity;
  CartModel({@required this.image, @required this.price, @required this.name, @required this.quantity});
}