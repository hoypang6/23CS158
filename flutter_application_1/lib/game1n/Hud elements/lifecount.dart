
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game1n/gameself.dart';


class LifeCount extends Component with HasGameRef<GameSelf>{
  var countThru = TextComponent(
    text:'Life Remaining: 0/50',
    anchor: Anchor.center,
    position: Vector2(650, 20),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:20,
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([countThru]);
  }

  void updateLetThru(int count){
    countThru.text = 'Life Remaining: $count/50';
  }
  
}