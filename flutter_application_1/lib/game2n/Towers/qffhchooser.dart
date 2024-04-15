import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../gameself.dart';

class QffhChooser extends SpriteComponent with TapCallbacks, HasGameRef<GameSelf> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('qffh_icon.png'); //nontransparent icon for black background
    //angle =1.507;
    anchor = Anchor.center;
    size = Vector2(25, 50); // Set the size of your button
    position = Vector2(20, 170); // Position it accordingly
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print("casting QF 4.5");
    gameRef.qffhDraggerFactory();// Spawn a draggable bofors
  }
}