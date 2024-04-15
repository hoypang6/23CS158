import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame/flame.dart';
import 'package:flutter_application_1/game1b/Hud%20elements/balanceshower.dart';
import 'package:flutter_application_1/game1b/Hud%20elements/gameover.dart';
import 'package:flutter_application_1/game1b/Hud%20elements/noBuildWarning.dart';
import 'package:flutter_application_1/game1b/Hud%20elements/winningscreen.dart';
import 'package:flutter_application_1/game1b/MicrowaveDealerL1.dart';
import 'package:flutter_application_1/game1b/ToasterDealerL1.dart';
import 'package:flutter_application_1/game1b/Hud%20elements/lifecount.dart';
import 'package:flutter_application_1/game1b/VacuumDealerL1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../game1b/gameself.dart';


class Level1b extends World with HasGameRef<GameSelf>, HasCollisionDetection{
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
      case 1:
        wave2(); //wave 2, 10 toasters
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
    if(letThru + enemyDowned == 40){ //Next level condition, should sum with numbers of kills (NK)
      currentWave++;
      wave3();
    }
    if(letThru + enemyDowned == 60){ //Next level condition, should sum with numbers of kills (NK)
      currentWave++;
      wave4();
    }


    if(letThru == 20){ //lose condition

      addOver();
      gameRef.endGame();
    }
    if(letThru + enemyDowned == 80){ //Win condition, NK
      print(enemyDowned);
      print(letThru);
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

  Future<void> wave1() async { //3 roomba, 14 microwaves, 3 toaster (20)
    await Future.delayed(Duration(seconds: 5));
    for(var i =0;i<3;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addVacuum();
      //print(letThru);
    }
    for(var i =0;i<14;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
    for(var i =0;i<3;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addToaster();
      //print(letThru);
    }


    
  }
  Future<void> wave2() async { //5 roombas, 15 microwaves (40)
    await Future.delayed(Duration(seconds: 3));
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addVacuum();
      //print(letThru);
    }
    for(var i =0;i<15;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
  }
  Future<void> wave3() async { //5 toasters, 10 roomba, 5 microwaves (60)
    await Future.delayed(Duration(seconds: 3));
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addToaster();
      //print(letThru);
    }
    for(var i =0;i<10;i++){
      await Future.delayed(Duration(milliseconds: 800));
      addVacuum();
      //print(letThru);
    }
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
  }
  Future<void> wave4() async { //15 roomba, 5 microwaves (80)
    for(var i =0;i<15;i++){
      await Future.delayed(Duration(milliseconds: 800));
      addVacuum();
      //print(letThru);
    }
    for(var i =0;i<5;i++){
      await Future.delayed(Duration(milliseconds: 1000));
      addMicrowave();
      //print(letThru);
    }
  }

  
}





