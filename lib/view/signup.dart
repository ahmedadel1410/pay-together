import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_together/controller/dbcontroller.dart';

class Signup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }

}
class SignupState extends State<Signup>{
  DbController db= new DbController();
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();
  String error='';

  int validateemail(String email){
    if( email.startsWith(new RegExp('[a-z]'),0)){
      if(email.contains("@")){
        if(email.endsWith("@")){
          error="mail can't end with (@)!!";
          return 0;
        }
        else{
          var  username =email.split("@");
          if(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%\s-]').hasMatch(username[0])){
            error="email shouldn't contain special characters !!";
            return 0;
          }
          else if (username[0].endsWith('.')|| username[0].endsWith('_')||username[1].endsWith('@')){
            error='email must end with letter or number';
            return 0;
          }
          else if (!RegExp(r'^(?!.*[._]{2})[a-zA-Z0-9_.]+$').hasMatch(username[0])){
            error="email can't contain consecutive (.)or(_) ";
            return 0;
          }
          else if(username[1]=='gmail.com'|| username[1]=='yahoo.com'||username[1]=='outlook.com'){
            var usernamevalid=username[0]+username[1];
            if(usernamevalid.length<16){
              error="mail must be  at least 16 characters!";
              return 0;
            }
            else{
              return 1;
            }
          }
          else{
            error='mail unrecognized it should be\n    (gmail-yahoo-outlook)';
            return 0;
          }
        }
      }
      else {
        error='not a valid mail';
        return 0;
      }
    }
    else{
      error='email must start with a letter !';
      return 0;
    }
  }

  void signup()async{
    if(_name.text.trim().isEmpty||_email.text.trim().isEmpty||_password.text.trim().isEmpty||_confirmpassword.text.trim().isEmpty
    ||_name.text.length<3||_password.text.length<6||_confirmpassword.text.trim()!=_password.text.trim())  setState(()=>error='invalid');
    else if(validateemail(_email.text)==0) setState(()=> error);
    else {
      await db.signup(_email.text,_password.text,_name.text);
      if(db.loginState=='loggedin'){
        Navigator.of(context).pushReplacementNamed('/home');
      }
      else setState(()=>error='invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        backgroundColor: Colors.teal.shade700,
        title: new Text("Pay Together",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),

      ) ,
      body: new Container(
          padding: EdgeInsets.all(10),
          child: new ListView(
            children: [
              new Padding(padding: EdgeInsets.only(bottom: 20)),
              new TextField(
                controller: _name,
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
                    labelText: 'Your Name',
                    labelStyle: TextStyle(color: Colors.green, fontSize: 14),
                    fillColor: Colors.black54),
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
              new Padding(padding: EdgeInsets.only(bottom: 10)),

              new TextField(
                controller: _confirmpassword,
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
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(color: Colors.green, fontSize: 14),
                    fillColor: Colors.black54),
              ),
              new Padding(padding: EdgeInsets.only(bottom: 10)),
              new Text("$error",
                  style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 14,
                  )),

              new RaisedButton(onPressed: signup,
                color: Colors.green,
                child: new Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
              ),

            ],

          )
      ),

    );
  }

}