
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game2b/gameself.dart';


class NoBuildWarning extends Component with HasGameRef<GameSelf>{
  var congratsMsg = TextComponent(
    text:'',
    anchor: Anchor.center,
    position: Vector2(384, 192),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:30,
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([congratsMsg]);
  }

  void updateNoBuild(String warningMessage){ //update the no build
    congratsMsg.text = warningMessage;
    print("User tried placing on path");
  }
  
}