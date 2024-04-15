import 'package:flame/components.dart';
import 'package:flame/events.dart';
import '../gameself.dart';

class QffhDragger extends SpriteComponent with DragCallbacks, HasGameRef<GameSelf>{

  @override
  void onLoad() async{
    await super.onLoad();
    sprite = await gameRef.loadSprite('qffh_ghosted.png');
    size = Vector2(38, 70);
    position = Vector2(50, 170); //sideways, height
    anchor = Anchor.center;
    priority = 100;
  }
  @override
  void onDragStart(DragStartEvent event){ //raise priority above other objects
    priority = 100;
  }
  @override
  void onDragUpdate(DragUpdateEvent event){ //move the thing
    position += event.localDelta;
  }
  @override
  void onDragEnd(DragEndEvent event){ //todo, place component
    gameRef.qffhPlacer(position);
    removeFromParent();
    
  }
  @override
  void update(double dt){
    if(position.x>770){
      removeFromParent();
      print("x out of bound");
    }
    if(position.y<=0){
      removeFromParent();
      print("lower y out of bound");
    }
  }
}