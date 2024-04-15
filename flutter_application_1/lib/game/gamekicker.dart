import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_application_1/game/gameself.dart';
import 'package:flutter_application_1/game/buttonhandler.dart';


//This class is to start the game through building a widget and point to gamewidget
class GameKicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(20),
      child: GameWidget.controlled(
        gameFactory: GameSelf.new,
        overlayBuilderMap: {
          'ButtonHandler': (BuildContext context, GameSelf game){ //one overlay only despite saying overlays, don't ask me why, button to return to menu
            return ButtonHandler();
          
          },
        },
        
      ),
    );
  }
}

