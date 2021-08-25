import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbController {
  String loginState='';
  String googleEmail='';
  var globalchat = FirebaseFirestore.instance.collection('globalchat');
  Future googlelogin()async{
    GoogleSignIn googlesignin = new GoogleSignIn();
    await googlesignin.signIn().then((googleuser)async{
      await googleuser!.authentication.then((googleauth)async{
        final credential=GoogleAuthProvider.credential(
            idToken: googleauth.idToken,
            accessToken: googleauth.accessToken
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        loginState='loggedin';
        googleEmail=googleuser.email;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', googleuser.email);
      });

    }).catchError((e){
      loginState='cannot login with google';
    });
  }

  signup(String email , String password, String name)async{

   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password).then((user){
     user.user!.updateDisplayName(name);
     loginState='loggedin';
   }).catchError((e){
     loginState='cannot sign up';
   });

  }
  login(String email , String password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password).then((user){
      loginState='loggedin';
    }).catchError((e){
      loginState='cannot login';
    });
  }

  Future logout()async{
    GoogleSignIn googlesignin = new GoogleSignIn();
    if(await googlesignin.isSignedIn())await  googlesignin.disconnect();
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    await prefs.remove('email');
   }
   addmessage(String message, String userid, String username, String localarea){
    globalchat.doc(localarea).collection('messages').add({
      'username': username,
      'message':message ,
      'data' :DateTime.now().microsecondsSinceEpoch,
      'localarea': localarea,
      'userid': userid,
    });

   }

}