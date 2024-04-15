
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game/gameself.dart';


class GameOver extends Component with HasGameRef<GameSelf>{
  var overMsg = TextComponent(
    text:'',
    anchor: Anchor.center,
    position: Vector2(384, 192),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:50,
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([overMsg]);
  }

  void updateOver(){
    overMsg.text = 'Game Over!';
    print("received the L");
  }
  
}