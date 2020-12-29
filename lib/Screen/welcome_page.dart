import 'package:flutter/material.dart';
class WelcomePage extends StatelessWidget {

  Widget button(
      @required String name,
      @required Color color,
      @required Color textColor,
      @required Function ontap
      ){
        return Container(
          height: 45,
          width: 300,
          child: RaisedButton(
            color: color,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.green, width: 3
              ),
                borderRadius: BorderRadius.circular(30)
            ),
            onPressed: ontap,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor
              ),
            ),
          ),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: Center(
                child: Image.asset('images/MonAn.png'),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Wellcome to Tastee", style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green
                    ),
                  ),
                  Column(
                    children: [
                      Text("Oder food from our restaurent and "),
                      Text("Make reservantion in restaurent")
                    ],
                  ),
                  button("Login", Colors.green,Colors.white,(){}),
                  button("SigUp", Colors.white, Colors.green,(){})
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
