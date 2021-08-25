import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_together/controller/dbcontroller.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}
class HomeState extends State<Home>{
 DbController db = new DbController();

  void logout()async{
    await db.logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        actions: [
          new TextButton.icon(onPressed: logout, icon: new Icon(Icons.logout,color: Colors.white,), label: Text('Logout',style:  TextStyle(color: Colors.white),))
        ],
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        title: new Text("Chat",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
      ) ,
      body: ListView.builder(
            padding: EdgeInsets.all(5),
            itemCount:2 ,
            itemBuilder: (BuildContext context , int position){
              return new Card(
                margin: EdgeInsets.only(bottom: 20),
                elevation: 5,
                color:(position==0)?Colors.teal.shade700 : Colors.white70,
                child: new ListTile(
                  title:(position==0)?   new Text('General chat',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600))
                      :new Text('coming soon',style: TextStyle(color: Colors.blueGrey.shade800,fontSize: 18,fontWeight: FontWeight.w600)),
                  leading: new Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 20.0,
                        child:new Image.asset('images/5d2300ad5f855-Free-Office-Cartoon-Vector-Character.png'),

                      )
                    ],
                  ),
                  onTap:(position==0)? ()=>Navigator.of(context).pushNamed('/location'): null,
                ) ,
              );

            } ,


          ) ,

    );
  }

}