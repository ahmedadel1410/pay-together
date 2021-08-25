import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pay_together/view/globalchat.dart';

class Location extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LocationState();
  }

}
class LocationState extends State<Location>{
  String city='City';
  String localarea='LocalArea';
  String error='';

  goToGlobalChat(){
    if(city=='City'||localarea=='LocalArea') setState(()=> error='chose your city and your area');
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> new GlobalChat(localarea)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        title: new Text("location",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),

      ) ,
      body:new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text('CHOSE YOUR LOCATION',style: TextStyle(color: Colors.green,fontSize: 16,fontWeight: FontWeight.w700)),
            new Padding(padding: EdgeInsets.only(bottom: 15)),
            DropdownButton<String>(
              value: city,
        icon: const Icon(Icons.arrow_downward,color: Colors.green,),
        iconSize: 25,
        elevation: 25,
        style: const TextStyle(color: Colors.green,fontSize: 18),

        onChanged: (String? newValue) {
          setState(() {
            localarea='LocalArea';
            city = newValue!;
          });
        },
        items:<String>['City','القاهره','الجيزه']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
            new Padding(padding: EdgeInsets.only(bottom: 10)),
            DropdownButton<String>(
              value: localarea,
              icon: const Icon(Icons.arrow_downward,color: Colors.green,),
              iconSize: 25,
              elevation: 25,
              style: const TextStyle(color: Colors.green,fontSize: 18),

              onChanged: (String? newValue) {
                setState(() {
                  localarea = newValue!;
                });
              },
              items:(city=='الجيزه')? <String>['LocalArea','الهرم','الدقي','المهندسين','المنيب','العجوزه','اكتوبر','امبابه','بولاق الدكرور','العمرانيه','الوراق'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
                  :(city=='القاهره')? <String>['LocalArea','عين شمس','حدائق القبه','المطرية','البساتين','شيراتون','مدينه نصر','السلام','المرج','الباطنيه','مسطرد','الفجاله','طره','العباسيه','شبرا',
                'السيده زينب','باب اللوق','جاردن سيتى','الأزبكية','الضرب الاحمر','التجمع','الحلمية','الخلفاوي','الزمالك','المعادي','الزاويه الحمرا']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
                  :<String>['LocalArea']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()
            ),
            new Text("$error",
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontSize: 14,
                )),
            new Padding(padding: EdgeInsets.only(bottom: 15)),
            new RaisedButton(onPressed: goToGlobalChat,
              color: Colors.green,
              child: new Text('GO',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
            ),

            //
          ],
        ),
      )

    );
  }

}