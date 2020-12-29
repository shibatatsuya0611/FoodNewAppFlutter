import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/Screen/sign_up.dart';
import 'package:FoodNewApp/Screen/widget/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool loading = false;
  RegExp regExp = RegExp(LoginPage.pattern);
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  Future<void> LoginAuth() async{
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context)=> HomePage()
        )
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        globalKey.currentState.showSnackBar(SnackBar(content: Text('No user found for that email.')));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        globalKey.currentState.showSnackBar(SnackBar(content: Text('Wrong password provided for that user.')));
        setState(() {
          loading = false;
          print('loading false 1');
        });
        print('Wrong password provided for that user.');
      }
    }
    setState(() {
      loading = false;
    });
  }


  void validation(){
    if(email.text.trim().isEmpty || email.text.trim()==null&&password.text.trim().isEmpty || password.text.trim()==null){
      globalKey.currentState.showSnackBar(SnackBar(content: Text('all field is empty'),),);
    }
    if(email.text.trim().isEmpty || email.text.trim()==null){
      globalKey.currentState.showSnackBar(SnackBar(content: Text('email is empty'),),);
      return;
    }
    else if(!regExp.hasMatch(email.text)){
      globalKey.currentState.showSnackBar(SnackBar(
          content: Text("Please enter vail Email")
      )
      );
    }
    if(password.text.trim().isEmpty || password.text.trim()==null){
      globalKey.currentState.showSnackBar(SnackBar(content: Text('password is empty'),),);
      return;
    }
    else{
      setState(() {
        loading = true;
        print('loading true');
      });
      LoginAuth();

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   color: Colors.white,
        //   onPressed: (){
        //
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 150),
                child: Text("Login",style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    MyTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: email,
                    ),
                    // textField(
                    //   hintText: "Username",
                    //   icon: Icons.person_outline,
                    //   iconColor: Colors.white
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      hintText: "Password",
                      obscureText: true,
                      controller: password,
                    ),
                    // textField(
                    //   hintText: "Password",
                    //   icon: Icons.lock_outline,
                    //   iconColor: Colors.white
                    // ),
                  ],
                ),
              ),
              loading ? CircularProgressIndicator(): Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  width: 200,
                  height: 60,
                  child: RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    onPressed: (){
                      validation();
                    },
                    child: Text("Login", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New user ?", style: TextStyle(
                      color: Colors.grey
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context)=> SigUp()
                          )
                        );
                      },
                      child: Text("Register now.", style: TextStyle(
                        color: Colors.red
                      ),),
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
