import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/game/gameself.dart';

class ModChooser extends SpriteComponent with TapCallbacks, HasGameRef<GameSelf> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('boforsmodicon.png'); //nontransparent icon for black background
    //angle =1.507;
    anchor = Anchor.center;
    size = Vector2(25, 50); // Set the size of your button
    position = Vector2(20, 290); // Position it accordingly
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print("casting turretted bofors");
    gameRef.modDraggerFactory();// Spawn a draggable bofors
  }
}