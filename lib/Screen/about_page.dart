import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('About')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context)=>HomePage()
                )
            );
          },
        ),
      ),
      body: Container(
        // color: Colors.white,
      ),
    );
  }
}
