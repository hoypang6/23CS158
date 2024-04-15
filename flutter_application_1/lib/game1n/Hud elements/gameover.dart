
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game1n/gameself.dart';


class GameOver extends Component with HasGameRef<GameSelf>{
  var overMsg = TextComponent(
    text:'',
    anchor: Anchor.center,
    position: Vector2(384, 192),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:20,
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([overMsg]);
  }

  // ignore: non_constant_identifier_names
  void updateOver(int ED){
    overMsg.text = 'Game Over! You knocked $ED enemies down';
    print("received the L");
  }
  
}