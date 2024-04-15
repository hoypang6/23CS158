// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dayprogress.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/chart.dart';
import 'package:health/health.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class PointsConvert extends StatefulWidget {
  const PointsConvert({super.key});

 
  

  
  @override
  State<PointsConvert> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<PointsConvert> {
  @override
  void initState() {
    var weekList = startFinder().item1; 
    for (var i = 0; i < 7; i++){
      fetchStepData(weekList[i],i); //WL[0] = Monday, [1] tues, etc...
      if(((weekList[i].month)==(DateTime.now().month))&&((weekList[i].day)==(DateTime.now().day))){
          print((weekList[i].day));
          print(" equals to ");
          print((DateTime.now().day));
          dayIndex = i;
          print(" index is ");
          print(dayIndex);
      }
    }
    today = DateTime(weekList[dayIndex].year, weekList[dayIndex].month, weekList[dayIndex].day);
    todayTS = today.millisecondsSinceEpoch;
    print(today);
    print(todayTS);
    loadData();
    super.initState();


  }

  late int balance = 0; //total balance
  late int tBalance = 0; //todayBalance 
  late int utBalance = 0; //untouched balance (for comparison)
  late int lUtBalance = 0; //last week's untouched balance
  late int streak = 0;
  late int dayIndex; //index of day of the week
  late DateTime today; //date time of today (midnight) to compare
  late int todayTS; //timestamp of today (midnight) in MS
  late int lMonday; //timestamp of last monday
  late int cMonday; //timestamp of current monday
  late int streakDay;
  void loadData() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
    setState((){
      balance = saves.getInt('balance') ?? 0; //if used first time then it will be 0
      tBalance = saves.getInt('tBalance')?? 0 ;
      todayTS = saves.getInt('todayTS') ?? todayTS;
      lMonday = saves.getInt('lMonday') ?? (DateTime(weekList[0].year,weekList[0].month, weekList[0].day)).subtract(const Duration(days:7)).millisecondsSinceEpoch;
      cMonday = saves.getInt('cMonday') ?? (DateTime(weekList[0].year,weekList[0].month, weekList[0].day)).millisecondsSinceEpoch;
      utBalance = saves.getInt('utBalance') ?? 0;
      lUtBalance = saves.getInt('lUtBalance') ?? 0;
      streak = saves.getInt('streak') ?? 0;
      streakDay = saves.getInt('streakDay') ?? todayTS;

    });
    todayTS = DateTime(weekList[dayIndex].year, weekList[dayIndex].month, weekList[dayIndex].day).millisecondsSinceEpoch;
    print(dayIndex);
    print(lMonday);
  }



  var weekList = startFinder().item1; //Contains list of dates until start of the week
  var stringWL = startFinder().item2; //Contains list of dates until start of the week in STRING
  var stepList = List<int>.filled(7, 0); //This is where the activity go
  int getSteps = 0;
   // create a HealthFactory for use in the app, choose if HealthConnect should be used or not
  HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

  Future fetchStepData(DateTime start, int i) async { //you give the thingy a start date and which interation we are on
    int? steps;

    var types = [
      HealthDataType.STEPS,
    ];

    
    final now = start; //Time given by start range
    //print("start range is");
    //print(now);
    
    final midnight = DateTime(now.year, now.month, now.day); //00:00 of start range
    DateTime justb4 = midnight.subtract(const Duration(microseconds: 1)); //23:59 of the day before
    justb4 = justb4.add(const Duration(days: 1));
    //print(midnight);
    //print("the end range");
    //print(justb4);
    
    //print(stepList);
    
    var permissions = [
      HealthDataAccess.READ,
    ];

    bool requested = await health.requestAuthorization(types, permissions: permissions);

    if (requested) {
      try{
        steps = await health.getTotalStepsInInterval(midnight, justb4);
      }catch(error){
        //print("caught exception in getTotalStepsInInterval: $error");
      }

      final filler = (steps == null)? 0:steps; //verifications
      
      print('from $midnight to $justb4, the');
      print('total number of stpes: $filler');

      setState(() {
        getSteps = (steps == null)? 0:steps;
        //print(getSteps);
        getSteps = calcScore(getSteps);

        stepList[i] = getSteps;
        //print(stepList);
        //stepList[i] = (steps == null)? 0:steps;
        
      });
    } else {
      //print("Auth not granted");
    }
    tBalance = stepList[dayIndex];
  } 


  @override
  Widget build(BuildContext context){
    print(stepList);
    return Scaffold( 
      
      appBar: AppBar(
        title: Text('Your Activity'),
        centerTitle: true,
        leading: BackButton(
            onPressed: (){
            //go home
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
      body: SingleChildScrollView(
         //makes view scrollable instead of overflowing
        child: Column(children: [
          
          Container(
            padding: EdgeInsets.only(top: 30),
            height: 150,
            width: 360,
            child: Chart(stepList: stepList,weekList: weekList,stringWL: stringWL), //passing stuff to the cart
          ),
          ElevatedButton(
              child: const Text("Claim today's points"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
                ),
              onPressed: (){
              //claim today's reward
                updateBalance();
              },
            ),
            RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "Current balance: $balance",         
                style: const TextStyle(  
                color: Colors.black,
                fontSize:15,
              )
            )
          ),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "Points gained last week: $lUtBalance",
              
                style: const TextStyle(
                  
                  color: Colors.black,
                fontSize:15,
              )
            )
          ),
            RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: "Current streak: $streak",
              
                style: const TextStyle(
                  
                  color: Colors.black,
                fontSize:15,
              )
            )
          ),
          ListView.builder(
            shrinkWrap: true, //make it fit in the screen
            // Let the ListView know how many items it needs to build.
            itemCount: 7,
            // Convert each item into a widget based on the type of item it is.
            itemBuilder: (context, index){
              //final stringed = stringWL;
              final WL = stringWL[index];
              final SLi = stepList[index];
              return Card(
                child:ListTile(
                  title: Text(WL), //date
                  subtitle: Text('Score: $SLi'), //score
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context)=> DayProgress(score:SLi,),
                      )
                    );
                  }
                ),
              );
            } 
          ),
        ],)
      )
      
    );
  }

  void updateBalance() async{
    final SharedPreferences saves = await SharedPreferences.getInstance();
   
    if((DateTime.fromMillisecondsSinceEpoch(cMonday)) != DateTime(weekList[0].year,weekList[0].month, weekList[0].day)){
      lUtBalance = saves.getInt('utBalance')!;
      saves.setInt('lUtBalance',lUtBalance);
      saves.setInt('utBalance',0);
      saves.setInt('cMonday',  (DateTime(weekList[0].year,weekList[0].month, weekList[0].day)).millisecondsSinceEpoch);  
    }
   

    if(saves.getInt('todayTS') == null){
      print("saved timestamp is null");
      saves.setInt('todayTS', todayTS);
    }
    if(saves.getInt('utBalance') == null){
      print("utBalance is null, resetting the 0");
      saves.setInt('utBalance', 0);
    }
    if(saves.getInt('tBalance') == null){
      print("tBalance is null, resetting the 0");
      saves.setInt('tBalance', 0);
    }
    if(saves.getInt('streak')==null){
      print("streak is null, resetting the 0");
      saves.setInt('streak', 0);
    }
    DateTime savedToday = DateTime.fromMillisecondsSinceEpoch(saves.getInt('todayTS')!);
    if(savedToday.add(const Duration(days: 1)).subtract(const Duration(seconds: 1)).isBefore(today)){ //check if it is a new day
      print(savedToday);
      print(" + 1 day is before ");
      print(today);
      saves.setInt('tBalance',0);
      tBalance = stepList[dayIndex] - saves.getInt('tBalance')!;
      
      balance = balance+tBalance; //merge yesterday's balance with total
      
      print(balance);
      
      saves.setInt('balance', balance); //save it
      saves.setInt('utBalance',balance); //save an untouched version
      saves.setInt('tBalance',stepList[dayIndex]); //load new tbalance
      saves.setInt('todayTS',todayTS); //update the day
      
      print("it's a new day");
    }else{
      
      print(savedToday);
      print(" + 1 day is the same as ");
      print(today);
      print("tbalance is ");
      print(tBalance);
      print(saves.getInt('tBalance'));
      print(saves.getInt('utBalance'));

      if(tBalance >= 1000){
        streak = saves.getInt('streak')! + 1;
      }else{
        saves.setInt('streak',0);
      }

      tBalance = stepList[dayIndex] - saves.getInt('tBalance')!;
      balance = balance+tBalance;
      saves.setInt('balance', balance); //save it
      
      if(saves.getInt('balance')!>saves.getInt('utBalance')!){
        saves.setInt('utBalance',balance); //save an untouched one
      }
      saves.setInt('tBalance',stepList[dayIndex]); //load new tbalance

      print("balance is ");
      print(saves.getInt('balance'));
      print("untouched is ");
      print(saves.getInt('utBalance'));
    
      print("same ol day");
    }
  }
}

int calcScore(int tempSteps){
  int fScore = tempSteps; //finalscore
  int p1 = 0; //part 1 (0-2 miuntes) Double Points
  int p2 = 0; //part 2 (2-18 minutes) In between
  int p3 = 0; //part 3 (18-20 minutes) Double Points
  int p4 = 0; //part 4 (20-40 minutes) 1:1
  if(tempSteps - 2000 > 0){
    p1 = 200;
    p2 = 600;
    p3 = 200; //if it's above 2k then you already have 1k points in the bank
    p4 = ((tempSteps-2000)/2).round();
  }else{
  if(tempSteps - 1800 >0 ){
    p1 = 200;
    p2 = 600;
    p3 = ((tempSteps-1800)).round(); //double points
  }else{
  if(tempSteps - 200 >0 ){
    p1 = 200;
    p2 = (((tempSteps-200) * 37.5)/100).round(); //small drop
  }else{
    if(tempSteps <= 200){
    p1 = ((tempSteps)).round(); // /100 because 1 min steps = 100 steps
    } 
  }
  }
  }

  fScore = p1 + p2 + p3 + p4;
  if(fScore > 2000){
    fScore = 2000; //2000 points ceiling
  }
  return fScore;
}

Tuple2<List<DateTime>, List<String>> startFinder(){ //Find start of the week given date
    DateTime weekStart = DateTime.now();
    //DateTime rn = DateTime.now();
    
    for (var i = 0; i < 7; i++){
      if (weekStart.weekday==1){
        break;
      }else{
        weekStart = weekStart.subtract(const Duration(days: 1));
      }
    }
    DateTime dateFill = weekStart;
    final dateList = <DateTime>[];
    final stringDL = <String>[];
    //var curWeekday = rn.weekday;
    for (var i = 0;i<7;i++){
      dateList.insert(i, dateFill);
      String dateSlug ="${dateFill.day.toString()}-${dateFill.month.toString().padLeft(2,'0')}-${dateFill.year.toString().padLeft(2,'0')}"; //Readable date
      stringDL.insert(i, dateSlug);
      dateFill = dateFill.add(const Duration(days: 1));
    }
    //print(dateList);
    return Tuple2(dateList,stringDL);
}