import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/game/gameself.dart';

class DoforsDragger extends SpriteComponent with DragCallbacks, HasGameRef<GameSelf>{

  @override
  void onLoad() async{
    await super.onLoad();
    sprite = await gameRef.loadSprite('boforsghosted.png');
    size = Vector2(11, 70);
    position = Vector2(50, 110); //sideways, height
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
    gameRef.doforsPlacer(position);
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