import 'package:FoodNewApp/Screen/cart_page.dart';
import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {

  final String image;
  final String name;
  final int price;
  DetailPage({@required this.name, @required this.price, @required this.image});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context)=>HomePage()
              )
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
          ),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff3a3e3e),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                    ),),
                    Text('Any Text..', style: TextStyle(
                      color: Colors.white
                    ),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity --;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Icon(Icons.remove),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text('$quantity', style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  quantity ++;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                        Text('\$ ${widget.price}', style: TextStyle(
                            fontSize: 30,
                            color: Colors.white
                        ),)
                      ],
                    ),
                    Text('Description', style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),),
                    Text('The customer app is the one that the customer is going to use. That is the briefest description for this app. The customer app helps the customer to access the online food ordering platforms, search for the right restaurant or the dish they want to order, place their orders and pay easily.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                          onPressed: (){
                            provider.addToCart(
                                image: widget.image,
                                name: widget.name,
                                price: widget.price,
                                quantity: quantity,
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context)=> CartPage()
                              )
                            );
                          },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(0xff2b2b2b),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart, color: Colors.white,),
                            SizedBox(width: 10,),
                            Text('Add to cart', style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),)
                          ],
                        )
                      ),
                    )
                  ],
                ),
              )
          )
        ],
      ),

    );
  }
}
