import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/model/cart_model.dart';
import 'package:FoodNewApp/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  Widget cartItem({@required Function onTap,@required String image, @required String name, @required int price, @required int quantity}){
    return Row(
      children: [
        Container(
          width: 170,
          height: 170,
          // color: Colors.white,
          child: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200,
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Burger about acha hain",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "\$ $price",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_circle_outline, color: Colors.white,size: 30,),
                            onPressed: (){

                            },
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline, color: Colors.white,size: 30,),
                            onPressed: (){

                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white,),
                  onPressed: onTap,
                )
              ],
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    int total = provider.totalprice();
    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xff3a3e3e),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$ $total', style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
            Text("Check out", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white
            ),)
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context)=> HomePage()
              )
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: provider.cartList.length,
        itemBuilder: (ctx, index){
          provider.getDeleteIndex(index);
          return cartItem(
              image: provider.cartList[index].image,
              name: provider.cartList[index].name,
              price: provider.cartList[index].price,
              quantity: provider.cartList[index].quantity,
              onTap: (){
                provider.delete();
            },
          );
        },
      ),
    );
  }
}
