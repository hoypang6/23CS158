
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game2b/gameself.dart';


class WinningScreen extends Component with HasGameRef<GameSelf>{
  var congratsMsg = TextComponent(
    text:'',
    anchor: Anchor.center,
    position: Vector2(384, 192),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:40,
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([congratsMsg]);
  }

  void updateDub(){ //update the W(Dub)in
    congratsMsg.text = 'You have cleared the level!';
    print("received the win");
  }
  
}