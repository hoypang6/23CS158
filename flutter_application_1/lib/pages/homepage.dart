// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/achievements.dart';
import 'package:flutter_application_1/pages/debugpage.dart';
import 'package:flutter_application_1/pages/levelselectionpage.dart';
import 'package:flutter_application_1/pages/pointsconvert.dart';
import 'package:flutter_application_1/pages/settings.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
          
            ElevatedButton(
              child: const Text("Start Game"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
                ),
              onPressed: (){
              //go to Level Selection Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> LevelSelectionPage(),
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Your Activity"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
              ),
              onPressed: (){
                //go to game
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> PointsConvert(),
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Achievements"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
              ),
              onPressed: (){
                //go to achievements
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> Achievements(),
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Settings"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200,40),
              ),
              onPressed: (){
                //go to settings
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> Settings(),
                  )
                );
              },
            ),
            // const SizedBox(height: 30), //this is the debug menu, commented to disable it
            // ElevatedButton(
            //   child: const Text("Debug"),
            //   style: ElevatedButton.styleFrom(
            //     fixedSize: Size(200,40),
            //   ),
            //   onPressed: (){
            //     //go to settings (place holder)
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //       builder: (context)=> DebugPage(),
            //       )
            //     );
            //   },
            // ),
           
          ],
        )
        
      )
    );
  }
}