import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'Towers/bulletauto.dart';
import 'Towers/bulletdofors.dart';
import 'Towers/bulletmod.dart';
import 'Towers/bulletqffh.dart';
import 'gameself.dart';
import 'Hud%20elements/lifecount.dart';

class VacuumDealerL1 extends SpriteComponent with CollisionCallbacks, HasGameRef<GameSelf>{
  VacuumDealerL1({required this.onThru, required this.enemyDowned});
  //bool spawned = false;
  int speed = 100; //default to 50
  int hp = 250; //Hit Points
  late final LifeCount lifeCount = LifeCount();
  final VoidCallback? onThru;
  final VoidCallback? enemyDowned;
  Vector2 velocity = Vector2.zero();
  bool met = false;
  List<bool> point = [true,false,false,false,false,false,false,false,false,false,false];
  List<bool> rotate = [false,false,false,false,false,false,false,false,false,false,false];



 @override
  void onLoad() async{
    //spawned =true;
    await super.onLoad();
    sprite = await gameRef.loadSprite('vacuum.png');
    size = Vector2(40, 40);
    position = Vector2(180, 0); //sideways, height (x,y)
    anchor = Anchor.center;
    add(
      RectangleHitbox( size:Vector2(40,40))
    );
  }
  @override
  void update(double dt){
    if(point[0]==true){ //start of waypoint
      if((position.x <= 180) && (position.y<=320) && (point[0]==true)){ //crude "pathfinding" -x to left -y to up
        position.y += dt*speed;
      }
      if(position.y >= 319 && (point[0]==true)){ //switch position
        point[0]=true;
        
        point[1]=true; //trigger the next one
        point[0]=false; //end this one
      }
    }
    if(point[1]==true){
      point[0]=false; //double assurance
      if(rotate[0]==false){
      angle = 0; //top dead
      rotate[0]=true;
      }
      if((position.x<=300)){
        position.x += dt*speed;
      }
      }if(position.x >= 299 && (point[1]==true)){
        point[2]=true;
        point[1] = false;
    }
    if(point[2]==true){
      point[1] = false;
      if(rotate[1]==false){
        angle = 4.71239; //90 counter
        rotate[1]=true;
      }
      if((position.y >= 75)&& (point[2]==true)){ 
        position.y -= dt*speed;
      } 
      if((position.y <= 76)&& (point[2]==true)){
        point[3] = true;
        point[2] = false;
      }
    }
    if(point[3]==true){
      point[2] = false;
      if(rotate[2]==false){
        angle = 0; //top dead
        rotate[2]=true;
      }
      if((position.x <= 590)&& (point[3]==true)){ 
        position.x += dt*speed;
      } 
      if((position.x >= 589)&& (point[3]==true)){
        point[4] = true;
        point[3] = false;
      }
    }
    if(point[4]==true){
      point[3] = false;
      if(rotate[3]==false){
        angle = 1.5708; //90 clock
        rotate[3]=true;
      }
      if((position.y <= 200)){ 
        position.y += dt*speed;
      }if((position.y >= 199)&& (point[4]==true)){
        point[5] = true;
        point[4] = false;
      }
    }
    if(point[5]==true){
      point[4] = false;
      if(rotate[4]==false){
        angle = 3.1415; //180
        rotate[4]=true;
      }
      if((position.x >= 390)){ 
        position.x -= dt*speed;
      }if((position.x <= 391)&& (point[5]==true)){
        //print("handover to point6");
        point[6] = true;
        point[5] = false;
      }
    }
    if(point[6]==true){
      point[5]=false;
      if(rotate[5]==false){
        angle = 1.5708; // 90 clock
        rotate[5]=true;
      }
      if((position.y <=300)){
        position.y += dt*speed;
      }
      if((position.y>=299)){
        point[7]=true;
        point[6]=false;
      }
    }
    if(point[7]==true){
      point[6]=false;
      if(rotate[6]==false){
        angle = 0; //top dead
        rotate[6]=true;
      }
      if((position.x <= 770)){
        position.x += dt*speed;
      }if((position.y>=769)){
        point[8]=true;
        point[7]=false;
      }
    }
    if(position.x>770){
      updateThru();
      removeFromParent();
    }
    if(hp <= 0){
      updateED();
      removeFromParent();

    }
    super.update(dt);
  }
  void updateThru(){
    
    onThru?.call();
  }
  void updateED(){
    enemyDowned?.call();
  }
  Vector2 getPos (){
    return position;
  }

  @override
  void onCollisionStart(
    
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  )  {//print("found something");
    if (other is BulletDofors){
      print('bofors connected');
      other.removeFromParent;
      hp = hp-4;
      //removeFromParent(); //please handle passing the kill to game for scoring later
    }

    if (other is BulletQffh){
      print('qffh connected');
      other.removeFromParent;
      hp = hp-6;
    }

    if (other is BulletAuto){
      print('auto connected');
      other.removeFromParent;
      hp = hp-8;
    }
    if (other is BulletMod){
      print('turretted connected');
      other.removeFromParent;
      hp = hp-10;
    }
  }

}
