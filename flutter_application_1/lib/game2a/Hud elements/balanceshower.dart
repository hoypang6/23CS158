
import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter_application_1/game2a/gameself.dart';


class BalanceShower extends Component with HasGameRef<GameSelf>{
  late int newBal;
  late int gameBill;
  BalanceShower({required this.newBal});
  var newBalance = TextComponent(

    text:'',
    anchor: Anchor.center,
    position: Vector2(100, 20),
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize:20,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0, 0),
            blurRadius: 30.0,
            color: Colors.black,
          )
        ]
      )
    ),
  );
  @override
  Future<void> onLoad() async{
    await addAll([newBalance]);
  }

  void updateBalance(int gameBill, int newBal){
    newBalance.text = 'Balance: $gameBill/$newBal';
  }
  
}