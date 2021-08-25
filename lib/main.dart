import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_together/view/home.dart';
import 'package:pay_together/view/location.dart';
import 'package:pay_together/view/login.dart';
import 'package:pay_together/view/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? email;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  email = pref.getString('email');
  await Firebase.initializeApp();
  print(email);

  runApp(Myapp());
}
class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Pay together' ,
      routes: <String , WidgetBuilder>{

        '/login':(BuildContext context)=>new Login(),
        '/signup':(BuildContext context)=>new Signup(),
        '/home':(BuildContext context)=>new Home(),
        '/location':(BuildContext context)=>new Location(),
      } ,
      home:(email==null) ? new Login()
          : new Home()
    );

  }
}