
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_together/controller/dbcontroller.dart';

class GlobalChat extends StatefulWidget{
  final localarea;
  GlobalChat(this.localarea);
  @override
  State<StatefulWidget> createState() {
    return GlobalChatState();
  }

}
class GlobalChatState extends State<GlobalChat>{
  TextEditingController _message = new TextEditingController();
  DbController db= new DbController();
  var user=FirebaseAuth.instance.currentUser!;
  final  globalchat = FirebaseFirestore.instance.collection('globalchat');


  void send(){
    if(_message.text.trim().isEmpty){}
    else{
      db.addmessage(_message.text,user.uid,user.displayName!,widget.localarea);
      _message.clear();
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar:new AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal.shade700,
          title: new Text("Global Chat",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),

        ) ,
        body:new Container(
          padding: EdgeInsets.all(10),
          child: new Column(
            children: [
              Expanded(child: StreamBuilder<QuerySnapshot>(
                //where('localarea',isEqualTo:"${widget.localarea}")
                stream: globalchat.doc(widget.localarea).collection('messages').orderBy('data',descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['message']),
                        subtitle: Text(data['username']),
                      );
                    }).toList(),
                  );
                },
              )


              ),

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
                        onPressed: send, icon: new Icon(Icons.send),)
                  )


                ],
              ),


            ],
          )
          ,)
    );

  }
  }
