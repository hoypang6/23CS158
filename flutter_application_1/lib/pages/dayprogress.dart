import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/pointsconvert.dart';

class DayProgress extends StatefulWidget{
  final int score;

  DayProgress({super.key, required this.score});
  
  @override
  State<DayProgress> createState() => dayProgressState();

}
class dayProgressState extends State<DayProgress>{
  //late final int score;
  int p1 = 0;
  int p2 = 0;
  int p3 = 0;
  int p4 = 0;
  int total = 0;
  @override
   void initState(){
    calcScore(widget.score);
    print(widget.score);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      appBar: AppBar(
        title: Text('Further Information'), //placeholder
        centerTitle: true,
        leading: BackButton(
            onPressed: (){
            //go back to PCS
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=> PointsConvert(),
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
        child: Container(

        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            const Text('You are recommended to perform 20 - 40 minutes of physical activity each day.'),
            const SizedBox(height:20),
            Text('First 2 Minutes - 1 Minute = 100 points: $p1'),
            const SizedBox(height:20),
            Text('Next 16 Minutes  - 1 Minute = 37.5 points: $p2'),
            const SizedBox(height:20),
            Text('Next 2 Minutes - 1 Minute = 100 points: $p3'),
            const SizedBox(height:20),
            Text('Next 20 Minutes - 1 Minute = 50 points: $p4'),
            const SizedBox(height:20),
            Text('Total (capped at 2000): $total'),
          ],

        ),
        )

      )
    );
  }
  void calcScore(int score){
    if(score - 1000 > 0){
      p1 = 200;
      p2 = 600;
      p3 = 200; //if it's above 2k then you already have 1k points in the bank
     p4 = ((score-1000)).round();
    }else{
    if(score - 800 >0 ){
      p1 = 200;
      p2 = 600;
      p3 = ((score-800)).round(); //double points
    }else{
    if(score - 200 >0 ){
      p1 = 200;
      p2 = (score-200).round(); //small drop
    }else{
      if(score <= 200){
      p1 = ((score)).round(); // /100 because 1 min steps = 100 steps
      } 
  }
  }
  }
    total = p1 + p2+p3+p4;
  }
  
    

}