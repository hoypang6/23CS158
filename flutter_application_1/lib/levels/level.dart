import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/flame.dart';

//level for testing if the engine starts 
//NOT USED IN FINAL PRODUCT


class Level extends World{

  late TiledComponent level;
  @override
  FutureOr<void> onLoad() async{
    await Flame.device.setLandscape(); //locking screen rotation

    level = await TiledComponent.load('test screen.tmx', Vector2.all(32)); //level name, pixel size
    
    
    

    add(level);
    
    return super.onLoad();
  }

 
}

