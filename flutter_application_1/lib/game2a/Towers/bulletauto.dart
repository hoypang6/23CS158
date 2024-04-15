import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../gameself.dart';

class BulletAuto extends SpriteComponent with CollisionCallbacks, HasGameRef<GameSelf>{
  SpriteComponent? bulletTarget;
  Vector2? turretPos;
  
  BulletAuto({required this.turretPos, required this.bulletTarget});

  @override
  void onLoad() async{
    await super.onLoad();
    sprite = await gameRef.loadSprite('autotracer.png');
    position = Vector2(turretPos!.x,turretPos!.y+35);
    size = Vector2(10,5);
    anchor = Anchor.bottomCenter;
    add(
      RectangleHitbox()
    );
  }
    @override
  void update(double dt){
    if(bulletTarget==null||bulletTarget!.isRemoved||position.x>780||position.x<0||position.y<0||position.y>400){
      removeFromParent();
      return;
    }
    if(position.distanceTo(turretPos!) > 160){
      removeFromParent();
      return;
    }
    lookAt(bulletTarget!.position);
    position.moveToTarget(bulletTarget!.position, 100*dt);
  
  }
}