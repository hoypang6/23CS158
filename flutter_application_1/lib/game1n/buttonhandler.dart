import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/homepage.dart';
class ButtonHandler extends StatelessWidget{ //this button's job is to bring you back to the menu
    const ButtonHandler({super.key});

    @override
    Widget build(BuildContext context){
      return Column(
        children: [
          IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed:(){
            //print('you clikced');
            Flame.device.setPortrait();
            Navigator.pop(context);
            Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context)=> const HomePage(),
                  )
              );
            },
          ),
        ],
      );
    }
}