import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/flame.dart';
import 'package:flutter_application_1/game/Hud%20elements/balanceshower.dart';
import 'package:flutter_application_1/game/Hud%20elements/gameover.dart';
import 'package:flutter_application_1/game/Hud%20elements/noBuildWarning.dart';
import 'package:flutter_application_1/game/Hud%20elements/winningscreen.dart';
import 'package:flutter_application_1/game/MicrowaveDealerL1.dart';
import 'package:flutter_application_1/game/ToasterDealerL1.dart';
import 'package:flutter_application_1/game/Hud%20elements/lifecount.dart';
import 'package:flutter_application_1/game/VacuumDealerL1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../game/gameself.dart';


class Level1 extends World with HasGameRef<GameSelf>, HasCollisionDetection{
  //int spawnedtoaster = 0;
  int letThru = 0;
  int currentWave = 0;
  int spawnedEnemy = 0;
  int enemyDowned = 0;

  late final SharedPreferences saves;
  late final GameOver gameOverScreen = GameOver();
  late final LifeCount lifeCount = LifeCount();
  late final WinningScreen wScreen = WinningScreen();
  late final NoBuildWarning noBuildWarning = NoBuildWarning();
  late final BalanceShower balanceShower = BalanceShower(newBal: 0);
  late int fornowBalance = 0;
  late int gameBill = 0; 
  late TiledComponent level;
  
  
  @override
  FutureOr<void> onLoad() async{

    await Flame.device.setLandscapeLeftOnly(); //locking screen rotation   
    saves = await SharedPreferences.getInstance();

    fornowBalance = saves.getInt('balance')??0;
    //balanceShower.updateBalance(gameBill, fornowBalance);
    level = await TiledComponent.load('beachside.tmx', Vector2.all(32)); //level name, pixel size
    startUnJam();
    add(level);
    add(lifeCount);
    add(gameOverScreen);
    add(wScreen);
    add(noBuildWarning);
    add(balanceShower);

    await super.onLoad();
    //addEnemyDelayed();
    // add(
    //   SpawnComponent(
    //     factory: (index) {
    //       return ToasterDealerL1();
    //     },
    //     period: 1,
      
    //     //area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
    //   ),
    // );
    //addEnemy();
    
    //wave1();
    waveStarter();

  }
  void addToaster(){
    add(ToasterDealerL1(onThru: updateThru, enemyDowned: updateED)); //make toasters
    //print("i tried");
  }

  void addMicrowave(){
    add(MicrowaveDealerL1(onThru: updateThru, enemyDowned: updateED));
  }

  void addVacuum(){
    add(VacuumDealerL1(onThru: updateThru, enemyDowned: updateED));
  }

  Future<void> waveStarter() async {
    switch(currentWave){
      case 0: //wave 1, 20 toasters
        wave1();
      // case 1:
      //   wave2(); //wave 2, 10 toasters
    }
  }
  void updateED(){ //enemy downed
    ++enemyDowned;
    checkConditions();
    
  }
  void updateThru(){
   ++letThru;
    lifeCount.updateLetThru(letThru);
    checkConditions();
    //print(letThru);

  }
  void checkConditions(){
    if(letThru + enemyDowned == 20){ //Next level condition, should sum with numbers of kills (NK)
      currentWave++;
      wave2();
    }
    if(letThru + enemyDowned == 35){ //Next level condition, should sum with numbers of kills (NK)
      currentWave++;
      wave3();
    }
    if(letThru + enemyDowned == 55){ //Next level condition, should sum with numbers of kills (NK)
      currentWave++;
      wave4();
    }
    if(letThru == 30){ //lose condition

      addOver();
      gameRef.endGame();
    }
    if(letThru + enemyDowned == 80){ //Win condition, NK
      gameRef.onWin();
      addWin();
      gameRef.endGame(); 
    }
  }
  void startUnJam(){
    gameRef.unJam();
  }
  void addOver(){
    gameOverScreen.updateOver(); //tell gameoverscreen to show it's over
  }

  void addWin(){
    wScreen.updateDub(); //tell them the W
  }

  Future<void> wave1() async { //20 toasters
  await Future.delayed(Duration(seconds: 5));
    for(var i =0;i<20;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addToaster();
      //print(letThru);
    }
    
  }
  Future<void> wave2() async { //10 toasters 5 microwaves (35)
    await Future.delayed(Duration(seconds: 3));
    for(var i =0;i<10;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addToaster();
      //print(letThru);
    }
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
  }
  Future<void> wave3() async { //20 microwaves (55)
      await Future.delayed(Duration(seconds: 3));
    for(var i =0;i<20;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
  }
  Future<void> wave4() async { //20 toasters, 5 roombas (80)
    await Future.delayed(Duration(seconds: 3));
    for(var i =0;i<20;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addToaster();
      //print(letThru);
    }
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addVacuum();
      //print(letThru);
    }
  }
  
}





