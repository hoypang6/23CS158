import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget{
  @override
  State<Settings> createState() => SettingPageState();


  //final stringWL WL;
  const Settings({super.key});
}
class SettingPageState extends State<Settings> {

  void loadData() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
  
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      
      appBar: AppBar(
        title: Text('Settings'), //placeholder
        centerTitle: true,
        leading: BackButton(
            onPressed: (){
            //go back to home
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> HomePage(),
                )
            );
          },
        ),
      ),
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Reset all progress"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
                ),
              onPressed: (){
                clearData(); //clear all data
              },
            ),
            
          ],
        )
        
      )
    );
  }

  void clearData() async{
    final SharedPreferences perfs = await SharedPreferences.getInstance();
    perfs.clear();
  }
}