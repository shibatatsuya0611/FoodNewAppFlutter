import 'package:FoodNewApp/Screen/about_page.dart';
import 'package:FoodNewApp/Screen/cart_page.dart';
import 'package:FoodNewApp/Screen/categories.dart';
import 'package:FoodNewApp/Screen/detail_page.dart';
import 'package:FoodNewApp/Screen/login_page.dart';
import 'package:FoodNewApp/Screen/profile_page.dart';
import 'package:FoodNewApp/Screen/widget/bottom_container.dart';
import 'package:FoodNewApp/model/categories_model.dart';
import 'package:FoodNewApp/model/food_categories_model.dart';
import 'package:FoodNewApp/model/foods_model.dart';
import 'package:FoodNewApp/model/user_model.dart';
import 'package:FoodNewApp/provider/my_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signOut() async {
    await _firebaseAuth.signOut();
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context)=> LoginPage()
      )
    );
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  List<CategoriesModle> burgerList = [];
  List<CategoriesModle> coffeList = [];
  List<CategoriesModle> drinkList = [];
  List<CategoriesModle> pizzaList = [];
  List<FoodModel> singleFoodList = [];
  List<FoodCategoriesModels> burgerCategoriesList = [];
  List<FoodCategoriesModels> coffeCategoriesList = [];
  List<FoodCategoriesModels> drinkCategoriesList = [];
  List<FoodCategoriesModels> pizzaCategoriesList = [];
  UserInforModel userData;

  Widget categoriesContainer(
      {@required Function onTap,
      @required String image,
      @required String name}){
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 60,
            width: 60,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image)),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
            ),
          ),
        ),
        SizedBox(height: 10,),
        Text(name, style: TextStyle(
            fontSize: 20,
            color: Colors.white,
        ),)
      ],
    );
  }
  Widget drawerItem({@required String name, @required IconData icon, @required Function onTap}){
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon,color: Colors.white,),
        title: Text(name, style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
    );
  }

  Widget burger(){
    return Row(
      children: burgerList.map((e) => categoriesContainer(
          image: e.image,
          name: e.name,
          onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context)=>Categories(
                  list: burgerCategoriesList,
                ),
              ),
            );
          }
      )).toList(),
    );
  }
  Widget coffe(){
    return Row(
      children: coffeList.map((e) => categoriesContainer(
          image: e.image,
          name: e.name,
          onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context)=>Categories(
                  list: coffeCategoriesList,
                ),
              ),
            );
          }
      )).toList(),
    );
  }
  Widget drink(){
    return Row(
      children: drinkList.map((e) => categoriesContainer(
          image: e.image,
          name: e.name,
          onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context)=>Categories(
                  list: drinkCategoriesList,
                ),
              ),
            );
          }
      )).toList(),
    );
  }
  Widget pizza(){
    return Row(
      children: pizzaList.map((e) => categoriesContainer(
          image: e.image,
          name: e.name,
          onTap: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context)=>Categories(
                  list: pizzaCategoriesList,
                ),
              ),
            );
          }
      )).toList(),
    );
  }
  Widget showDrawer(){
    return Drawer(
      child: Container(
        color: Color(0xff3a3e3e),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/backgroundimage.png')
                      )
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
                  accountName: Text(userData.name),
                  accountEmail: Text(userData.email)
              ),
              drawerItem(
                name: 'Profile',
                icon: Icons.person,
                onTap: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context)=>ProfilePage()
                      )
                  );
                },
              ),
              drawerItem(
                name: 'Cart',
                icon: Icons.shopping_cart,
                onTap: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context)=>CartPage()
                      )
                  );
                },
              ),
              drawerItem(
                name: 'Oder',
                icon: Icons.shop,
                onTap: (){

                },
              ),
              drawerItem(
                name: 'About',
                icon: Icons.info,
                onTap: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context)=>AboutPage()
                      )
                  );
                },
              ),
              Divider(
                thickness: 3,
                color: Colors.white,
              ),
              ListTile(
                leading: Text('Comunicate', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),),
              ),
              drawerItem(
                name: 'Change',
                icon: Icons.lock,
                onTap: (){

                },
              ),
              drawerItem(
                name: 'Logout',
                icon: Icons.exit_to_app,
                onTap: (){
                  signOut();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);


    provider.getBurger();
    burgerList = provider.throwBurger;

    provider.getCoffeCategory();
    coffeList = provider.throwCoffeList;

    provider.getDrinkCategory();
    drinkList = provider.throwDrinkList;

    provider.getPizzaCategory();
    pizzaList = provider.throwPizzaList;

    //////////sigle food/////
    provider.getFoodList();
    singleFoodList = provider.throwFoodModelList;

    provider.getBurgerCategoriesList();
    burgerCategoriesList = provider.throwBurgerCategoriesList;

    provider.getCoffeCategoriesList();
    coffeCategoriesList = provider.throwCoffeCategoriesList;

    provider.getDrinkCategoriesList();
    drinkCategoriesList = provider.throwDrinkCategoriesList;

    provider.getPizzaCategoriesList();
    pizzaCategoriesList = provider.throwPizzaCategoriesList;

    provider.getUserInfor();
    userData = provider.throwUserInfor;


    return Scaffold(
      key: _globalKey,
      drawer: showDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
              icon: Icon(Icons.sort),
              onPressed: ()=> _globalKey.currentState.openDrawer()
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CircleAvatar(
              // backgroundColor: Colors.red,
              backgroundImage: AssetImage('images/avatar.png'),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: onrefreshBottomContainer,
        child: bodyscreen(),
      ),
    );
  }

  Future<Null> onrefreshBottomContainer() async {

    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      userData;
      singleFoodList;
    });
    return null;
  }

  Widget bodyscreen(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search food",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white,),
                filled: true,
                fillColor: Color(0xff3a3e3e),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              burger(),
              coffe(),
              drink(),
              pizza(),
            ],
          ),
        ),
        Container(
          height: 408,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.count(
              shrinkWrap: false,
              primary: false,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: singleFoodList.map((e) => BottomContainer(
                image: e.image,
                price: e.price,
                name: e.name,
                onTap: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context)=> DetailPage(
                            name: e.name,
                            price: e.price,
                            image: e.image,
                          )
                      )
                  );
                },
              )
              ).toList()
          ),
        )
      ],
    );
  }
}
