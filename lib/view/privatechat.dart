import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateChat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PrivateChatState();
  }

}
class PrivateChatState extends State<PrivateChat>{
  TextEditingController _message = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:new AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal.shade700,
          title: new Text("Private Chat",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),

        ) ,
        body:new Container(
          padding: EdgeInsets.all(10),
          child: new Column(
            children: [
              Expanded(child:  new ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: 10,
                  itemBuilder:(context,int position){
                    return new ListTile(
                      leading: new Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.lightGreen,
                            radius: 18.0,
                            child:new Image.asset('images/5d2300ad5f855-Free-Office-Cartoon-Vector-Character.png'),

                          )
                        ],
                      ),
                      onTap:(position==0)? null: null,
                    );

                  }),),

              new Row(
                children: [
                  new SizedBox(
                    height:40 ,
                    width:300 ,
                    child:  new TextField(
                      controller: _message,
                      cursorColor: Colors.black54,

                      decoration: new InputDecoration(

                          enabledBorder: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          //    filled: true,

                          labelText: 'type your message',
                          labelStyle: TextStyle(color: Colors.green, fontSize: 14),
                          fillColor: Colors.black54),
                    ),

                  ),

                  Expanded(
                      child:new IconButton(
                        padding: EdgeInsets.all(double.minPositive),
                        color: Colors.green,
                        onPressed: ()=> debugPrint('ok'), icon: new Icon(Icons.send),)
                  )


                ],
              ),


            ],
          )
          ,)
    );
  }

}