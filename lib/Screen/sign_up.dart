import 'package:FoodNewApp/Screen/login_page.dart';
import 'package:FoodNewApp/Screen/widget/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SigUpState createState() => _SigUpState();
}

class _SigUpState extends State<SigUp> {

  bool loading = false;
  UserCredential userCredential;
  RegExp regExp = RegExp(SigUp.pattern);
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  
  Future sendData() async {
    try {
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
       await FirebaseFirestore.instance.collection('userData').doc(userCredential.user.uid).set({
          'first name': firstName.text.trim(),
          'last name': lastName.text.trim(),
          'email': email.text.trim(),
          'userid': userCredential.user.uid,
          'password': password.text.trim(),
        });
        globalKey.currentState.showSnackBar(
            SnackBar(
              content: Center(
                child: Text('Dang ki thanh cong', style: TextStyle(
                  fontSize: 25,
                ),),
              ),
            )
        );

        setState(() {
          loading = false;
        });

       // Navigator.of(context).pushReplacement(
       //   MaterialPageRoute(
       //     builder: (context)=> LoginPage()
       //   )
       // );


    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        globalKey.currentState.showSnackBar(SnackBar(content: Text('The password provided is too weak.'),),);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        globalKey.currentState.showSnackBar(SnackBar(content: Text('The account already exists for that email.'),),);
        print('The account already exists for that email.');
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(e),
        ),
      );
      setState(() {
        loading = false;
      });
      print(e);
    }

  }
  
  void validation(){
    if(firstName.text.trim().isEmpty||firstName.text.trim()== null){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("First Name is Empty")
        )
      );
      return;
    }
    if(lastName.text.trim().isEmpty||lastName.text.trim()== null){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Last Name is Empty")
      )
      );
      return;
    }
    if(email.text.trim().isEmpty||email.text.trim()== null){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Email is Empty")
      )
      );
      return;
    }
    else if(!regExp.hasMatch(email.text)){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Please enter vail Email")
      )
      );
    }
    if(password.text.trim().isEmpty||password.text.trim()== null){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Password is Empty")
      )
      );
      return;
    }
    else {
      setState(() {
        loading = true;
      });
      sendData();
    }
  }

  Widget button({@required String buttonName, @required Color color, @required Color textColor, @required Function ontap}){
    return Container(
      width: 100,
      child: RaisedButton(
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        onPressed: ontap,
        child: Text(buttonName, style: TextStyle(
            fontSize: 15,
            color: textColor
        ),),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      // backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Sign Up", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40
              ),),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextField(hintText: "fistName",obscureText: false,controller: firstName,),
                      MyTextField(hintText: "LastName", obscureText: false,controller: lastName,),
                      MyTextField(hintText: "Email", obscureText: false,controller: email,),
                      MyTextField(hintText: "Password", obscureText: true,controller: password,)
                    ],
                  ),
                ),
              ),
              loading ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ) : Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    button(
                        buttonName: "Cancel",
                        color: Colors.grey,
                        textColor: Colors.black,
                        ontap: (){
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context)=> LoginPage()
                            )
                          );
                        }
                    ),
                    SizedBox(width: 20,),
                    button(
                        buttonName: "Register",
                        color: Colors.red,
                        textColor: Colors.white,
                        ontap: (){
                          validation();
                        }
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
