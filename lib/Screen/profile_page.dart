import 'package:FoodNewApp/Screen/home_page.dart';
import 'package:FoodNewApp/model/user_model.dart';
import 'package:FoodNewApp/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  UserInforModel userData;

  _intToDate({@required int value}){
    final df = DateFormat('dd/MM/yyyy');
    int myvalue = value;
    return df.format(DateTime.fromMillisecondsSinceEpoch(myvalue*1000));
  }

  _dateToInt({@required String date}){
    var now = DateTime.now();
    print('My int: ${int.tryParse('$now')}');
  }

  Widget actionItem({@required String name, @required IconData icon}){
    return ListTile(
      leading: Icon(icon, color: Colors.white,),
      title: Text(name, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),),
    );
  }

  Widget infoPerson(){
    return Column(
      children: [
        actionItem(
            name: userData.name,
            icon: Icons.person
        ),
        actionItem(
            name: _intToDate(value: userData.dayofbirth),
            icon: Icons.view_day
        ),
        actionItem(
            name: userData.address,
            icon: Icons.location_city
        ),
        actionItem(
            name: userData.email,
            icon: Icons.email
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider =  Provider.of(context);

    provider.getUserInfor();
    userData = provider.throwUserInfor;

    // print('userdata: ${userData.name}');
    // _dateToInt(date: '25/01/2012');

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
      body: Column(
        children: [
          Container(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('images/avatar.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: infoPerson()
          )
        ],
      ),
    );
  }
}
