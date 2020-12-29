import 'package:FoodNewApp/Screen/detail_page.dart';
import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/Screen/widget/bottom_container.dart';
import 'package:FoodNewApp/model/food_categories_model.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  List<FoodCategoriesModels> list = [];
  Categories({@required this.list});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // title: Text('Burger'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context)=>HomePage()
                )
            );
          }
        ),
      ),
      body: GridView.count(
          shrinkWrap: false,
          primary: false,
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children:
          list.map(
                  (e) => BottomContainer(
                    onTap: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context)=>DetailPage(
                                name: e.name,
                                price: e.price,
                                image: e.image
                            )
                        )
                      );
                    },
                      image: e.image,
                      price: e.price,
                      name: e.name,
                  )).toList()
      ),
    );
  }
}
