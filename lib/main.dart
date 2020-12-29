import 'package:FoodNewApp/Screen/cart_page.dart';
import 'package:FoodNewApp/Screen/detail_page.dart';
import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/Screen/login_page.dart';
import 'package:FoodNewApp/Screen/profile_page.dart';
import 'package:FoodNewApp/Screen/sign_up.dart';
import 'package:FoodNewApp/Screen/welcome_page.dart';
import 'package:FoodNewApp/provider/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          // primaryColor: Colors.blue,
          // accentColor: Colors.blue,
          // textSelectionColor: Colors.red
          appBarTheme: AppBarTheme(
            color: Color(0xff2b2b2b)
          )
        ),
        // home: ProfilePage(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (index,sncpshot){
            if(sncpshot.hasData){
              return HomePage();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}
