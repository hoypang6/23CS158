import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/game1b/gameself.dart';

class AutoChooser extends SpriteComponent with TapCallbacks, HasGameRef<GameSelf> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('autoicon.png'); //nontransparent icon for black background
    //angle =1.507;
    anchor = Anchor.center;
    size = Vector2(30, 50); // Set the size of your button
    position = Vector2(20, 230); // Position it accordingly
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print("casting automagic");
    gameRef.autoDraggerFactory();// Spawn a draggable bofors
  }
}