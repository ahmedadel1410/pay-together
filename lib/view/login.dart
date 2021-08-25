import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pay_together/controller/dbcontroller.dart';


class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
return loginState();
  }

}
class loginState extends State<Login>{

  DbController db= new DbController();
  String error='';
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  void googleLogin()async{
   await db.googlelogin();
    if(db.loginState=='loggedin') Navigator.pushReplacementNamed(context, '/home');
    else setState(() => error=db.loginState);
  }
  void login()async{
    if(_email.text.isEmpty||_password.text.isEmpty)setState(()=> error = 'invalid');
    else
      {
        await db.login( _email.text ,_password.text);
        if(db.loginState=='loggedin') Navigator.pushReplacementNamed(context, '/home');
        else setState(() => error=db.loginState);
      }
  }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar:new AppBar(
      backgroundColor: Colors.white,
      title: new Text("Pay Together",style: TextStyle(color: Colors.green,fontSize: 18,fontWeight: FontWeight.w600),),

    ) ,
    body: new Container(
      padding: EdgeInsets.only(top: 10,left: 20,right: 20),
        child: new ListView(
          children: [
            new Image.asset(
              'images/5d2300ad5f855-Free-Office-Cartoon-Vector-Character.png',
              height: 200,
              width: 100,

            ),
            new Padding(padding: EdgeInsets.only(bottom: 10)),
          new TextField(
          controller: _email,
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
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.green, fontSize: 14),
              fillColor: Colors.black54),
        ),
            new Padding(padding: EdgeInsets.only(bottom: 10)),

            new TextField(
              controller: _password,
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
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.green, fontSize: 14),
                  fillColor: Colors.black54),
            ),
            new Text("$error",
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 14,
                )),
            new RaisedButton(onPressed:login,
              color: Colors.green,
              child: new Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            Row(
                  children: [
                    Expanded(
                        child:new ElevatedButton.icon(onPressed:googleLogin ,
                          icon: new FaIcon(FontAwesomeIcons.google , color: Colors.blue.shade700,),
                          label: new Row(children: [new Text('oog',style: TextStyle(color: Colors.orange,fontSize: 28)),
                            new Text('le',style: TextStyle(color: Colors.red,fontSize: 28))]),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green),

                          ),
                        )
                    )
                  ]
              ),

            new TextButton(onPressed:()=>Navigator.pushNamed(context, '/signup'), child: new Text('Sign up',style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.w600),))

          ],

    )
    ),

  );
  }

}