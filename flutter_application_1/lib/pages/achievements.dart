import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Achievements extends StatefulWidget{
  //final stringWL WL;
  const Achievements({super.key});
    @override
  State<Achievements> createState() => AchievementsPageState();
}

class AchievementsPageState extends State<Achievements> {
  late bool level1Cleared = false; 
  late bool level1BCleared = false;
  late bool level2ACleared =false;
  late bool level2BCleared =false;

  void loadData() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      level1Cleared = saves.getBool('level1Cleared') ?? false; 
      level1BCleared = saves.getBool('level1BCleared') ?? false; 
      level2ACleared = saves.getBool('level2ACleared') ?? false; 
      level2BCleared = saves.getBool('level2BCleared') ?? false; 
    });
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
        title: const Text('Achievements'), //placeholder
        centerTitle: true,
        leading: BackButton(
            onPressed: (){
            //go back to home
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> const HomePage(),
                )
            );
          },
        ),
      ),
      body: SingleChildScrollView(
         //makes view scrollable instead of overflowing
        child: Column(children: <Widget>[
            ListTile(
              title: const Text('First Steps'),
              subtitle: const Text('Clearing Level 1 - 1'),
              trailing: level1Cleared? Icon(Icons.done):Icon(Icons.close),
            ),
            ListTile(
              title: const Text('A Small Leap'),
              subtitle: const Text('Clearing Level 1 - 2'),
              trailing: level1BCleared? Icon(Icons.done):Icon(Icons.close),
            ),
            ListTile(
              title: const Text('Going Places!'),
              subtitle: const Text('Clearing Level 2 - 1'),
              trailing: level2ACleared? Icon(Icons.done):Icon(Icons.close),
            ),
            ListTile(
              title: const Text('Disassembly Expert'),
              subtitle: const Text('Clearing Level 2 - 2'),
              trailing: level2BCleared? Icon(Icons.done):Icon(Icons.close),
            )
        ],
          )
      )
    );
  }
}

