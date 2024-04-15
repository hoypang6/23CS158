import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugPage extends StatefulWidget{
  //final stringWL WL;
  const DebugPage({super.key});
    @override
  State<DebugPage> createState() => AchievementsPageState();
}

class AchievementsPageState extends State<DebugPage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }
  late int balance = 0; //score balance
  late int tBalance = 0; //todayBalance 
  late DateTime today = DateTime.now(); 
  late int todayTS = today.millisecondsSinceEpoch;
  late int utBalance =0;
  late bool level1Cleared = false; //have you passed level 1

  void loadData() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      balance = saves.getInt('balance') ?? 0; //if used first time then it will be 0
      level1Cleared = saves.getBool('level1Cleared') ?? false; 
      tBalance = saves.getInt('tBalance')?? 0 ;
      todayTS = saves.getInt('todayTS') ?? todayTS;
      utBalance = saves.getInt('utBalance')??0;
    });
  }


  @override
  Widget build(BuildContext context){
    return Scaffold( 
      
      appBar: AppBar(
        title: Text('Debug'), //placeholder
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
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.help_outline),
        //     onPressed: (){
              
        //     },
        //   )
        // ]
      ),
       body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomRow(balance, updateBalance, 'balance'),
            const SizedBox(height:20),
            CustomRow(balance, refreshBalance, 'refresh balance'),
            const SizedBox(height:20),
            CustomRow(level1Cleared, resetL1C, 'reset level1Cleared'),
            const SizedBox(height:20),
            CustomRow(tBalance, refreshtBalance, 'tBalance'),
            const SizedBox(height:20),
            CustomRow(tBalance, resettBalance, 'reset tBalance'),
            const SizedBox(height:20),
            // CustomRow(today, resettoday, 'reset today'),
            // const SizedBox(height:20),
            CustomRow(utBalance, resetutBalance, 'reset utBalance'),
            const SizedBox(height:20),
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
  Row CustomRow(data,Function()? onPressed, String buttonText){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$data'),
        ElevatedButton(onPressed: onPressed, child: Text(buttonText),
        ),
      ],
    );
  }
  void refreshBalance() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      balance = saves.getInt('balance')!;
      saves.setInt('balance', balance);
    });
  }
  void refreshtBalance() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      tBalance = saves.getInt('tBalance')!;
      saves.setInt('tBalance', tBalance);
    });
  }
  void resettBalance() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      saves.setInt('tBalance', 0);
      tBalance = saves.getInt('tBalance')!;
    });
  }
  void updateBalance() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      balance = 500;
      saves.setInt('balance', balance);
    });
  }
  void resetL1C() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      saves.setBool('level1Cleared',false);
      level1Cleared = saves.getBool('level1Cleared')!;
      //saves.setInt('balance', balance);
    });
  }
  void resettoday() async{
     final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      saves.setInt('todayts',0);
      todayTS = saves.getInt('todayTS')!;
      //saves.setInt('balance', balance);
    });
  }
  void resetutBalance() async{
     final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      saves.setInt('utBalance',0);
      todayTS = saves.getInt('utBalance')!;
      //saves.setInt('balance', balance);
    });
  }
  void clearData() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    saves.clear();
  }
}

