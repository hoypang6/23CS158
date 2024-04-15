import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../gameself.dart';


class DoforsChooser extends SpriteComponent with TapCallbacks, HasGameRef<GameSelf> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('boforsicon.png'); //nontransparent icon for black background
    //angle =1.507;
    anchor = Anchor.center;
    size = Vector2(15, 50); // Set the size of your button
    position = Vector2(20, 110); // Position it accordingly
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    print("casting dofots");
    gameRef.doforsDraggerFactory();// Spawn a draggable bofors
  }
}