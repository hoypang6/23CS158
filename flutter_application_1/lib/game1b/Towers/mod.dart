import 'dart:math';


import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../ToasterDealerL1.dart';

import '../gameself.dart';

import '../MicrowaveDealerL1.dart';
import '../VacuumDealerL1.dart';
//import 'package:vector_math/vector_math.dart' hide Vector2;

class Mod extends SpriteComponent with CollisionCallbacks, HasGameRef<GameSelf>{ 
  final Vector2 dropPosition; //the position where you are dropping
  late Timer? timer;
  double targetAngle =0;
  bool fire=false;
  Vector2? targetPos; //position of the target
  SpriteComponent? target; //the target

  Mod(this.dropPosition); 
  void shoot(){ //supposed to fire guns but is now doing angling
    if(targetPos!=null){
      //print("tried rotating");
      targetAngle = atan((position.y-targetPos!.y)/(position.x-targetPos!.x));
      angle = targetAngle;
      //print(targetAngle);

    }else{
      //print("got nothing to aim at");
    }
  } 


  @override
  void onLoad() async{
    await super.onLoad();
    sprite = await gameRef.loadSprite('boforsmod.png'); //switch to unload, need to check
    size = Vector2(35, 70);
    position = dropPosition; //sideways, height
    anchor = Anchor.center;
    
    add(
      CircleHitbox(radius: 150,anchor: Anchor.center,position: Vector2(17.5,35.0))
    );
    
  }

  void compareEnemyDistance(Vector2 targetPosCan, PositionComponent candidate){ //position candidate
    if(targetPos == null){
      targetPos = targetPosCan;
    }else{
      double canDistance = position.distanceTo(candidate.position);
      double curDistance = position.distanceTo(target!.position);
      if(curDistance>canDistance){
        targetPos = targetPosCan;
        target=candidate as SpriteComponent?;
      }
    }
  }
  callingShots(){
    if(fire == true){
      gameRef.modBulletFactory(position, target!);
    }

  }


  @override 
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {//print("found something");
    if (other is ToasterDealerL1){
      if(target == null || ((target is ToasterDealerL1)==false)||((target is VacuumDealerL1) == false)||((target is MicrowaveDealerL1) == false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    } else if(other is VacuumDealerL1){
      if(target == null || ((target is ToasterDealerL1)==false)||((target is VacuumDealerL1) == false)||((target is MicrowaveDealerL1) == false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    } else if(other is MicrowaveDealerL1){
        if(target == null || ((target is ToasterDealerL1)==false)||((target is VacuumDealerL1) == false)||((target is MicrowaveDealerL1) == false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints,PositionComponent other){
    if (other is ToasterDealerL1){
      if(target == null || ((target is ToasterDealerL1)==false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    } else if(other is VacuumDealerL1){
      if(target == null || ((target is ToasterDealerL1)==false)||((target is VacuumDealerL1) == false)||((target is MicrowaveDealerL1) == false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    } else if(other is MicrowaveDealerL1){
        if(target == null || ((target is ToasterDealerL1)==false)||((target is VacuumDealerL1) == false)||((target is MicrowaveDealerL1) == false)){
        target = other;
      }else{
        compareEnemyDistance(target!.position,other);
        shoot(); 
      }
    }
  }
  @override
  void onCollisionEnd(PositionComponent other){
    if(other != target){
      //target = other as SpriteComponent?;
    }else{
      target = SpriteComponent();
    }

  }
    
  

  @override
  Future<void> update(double dt) async {
    super.update(dt);
    if((target is ToasterDealerL1)||(target is MicrowaveDealerL1)||(target is VacuumDealerL1)){
      lookAt(target!.position);
      fire = true;
      callingShots();
      //timer.update(dt);
    }else{
      fire = false;
    }
    
  }

}