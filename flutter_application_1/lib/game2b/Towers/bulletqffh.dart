import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../gameself.dart';

class BulletQffh extends SpriteComponent with CollisionCallbacks, HasGameRef<GameSelf>{
  SpriteComponent? bulletTarget;
  Vector2? turretPos;
  
  BulletQffh({required this.turretPos, required this.bulletTarget});

  @override
  void onLoad() async{
    await super.onLoad();
    sprite = await gameRef.loadSprite('qffh_tracer.png');
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
    if(position.distanceTo(turretPos!) > 150){
      removeFromParent();
      return;
    }
    lookAt(bulletTarget!.position);
    position.moveToTarget(bulletTarget!.position, 100*dt);
  
  }
}