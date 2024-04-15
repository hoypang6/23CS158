import 'package:flutter/material.dart';
import 'package:flutter_application_1/game/gamekicker.dart';
import 'package:flutter_application_1/game1b/gamekicker1b.dart';
import 'package:flutter_application_1/game1n/gamekicker1n.dart';
import 'package:flutter_application_1/game2n/gamekicker2n.dart';

import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/infohelp.dart';

import '../game2a/gamekicker2a.dart';
import '../game2b/gamekicker2b.dart';


class LevelSelectionPage extends StatelessWidget{
  const LevelSelectionPage({
    super.key,
    // this.onPlayPressed, 
    // this.onLevelSelected,
    });
  // static const id = 'levelselection';
  // final ValueChanged<int>? onLevelSelected;
  // final VoidCallback? onPlayPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Levels Selection'),
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
      ),
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Information"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> InfoHelp()
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Level 1 - 1"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker(),fullscreenDialog: true,
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Level 1 - 2"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker1B(),fullscreenDialog: true,
                  )
                );
              },
            ),
            const SizedBox(height: 30),
                        ElevatedButton(
              child: const Text("Level 1 - Infinite Mode"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker1N(),fullscreenDialog: true,
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Level 2 - 1"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker2A(),fullscreenDialog: true,
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Level 2 - 2"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker2B(),fullscreenDialog: true,
                  )
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Text("Level 2 - Infinite Mode"),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(210,40),
                ),
              onPressed: (){
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> GameKicker2N(),fullscreenDialog: true,
                  )
                );
              },
            ),
            
          ],
        )
        
      )
    );
  }
}