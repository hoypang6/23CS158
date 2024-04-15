import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import '../levels/level1b.dart';
import 'Hud%20elements/balanceshower.dart';
import 'Hud%20elements/noBuildWarning.dart';
import 'Towers/auto.dart';
import 'Towers/autochooser.dart';
import 'Towers/autodragger.dart';
import 'Towers/bulletauto.dart';
import 'Towers/bulletdofors.dart';
import 'Towers/bulletmod.dart';
import 'Towers/bulletqffh.dart';
import 'Towers/dofors.dart';
import 'Towers/doforschooser.dart';
import 'Towers/doforsdragger.dart';
import 'Towers/mod.dart';
import 'Towers/modchooser.dart';
import 'Towers/moddragger.dart';
import 'Towers/qffh.dart';
import 'Towers/qffhchooser.dart';
import 'Towers/qffhdragger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pausebutton.dart';


class GameSelf extends FlameGame with TapDetector,PanDetector{ //now pushes only Level 1
  // @override
  //bool debugMode = true;
  late final SharedPreferences saves;
  bool stageWin = false; //bool to check if you have won the level
  bool notBuilding = false; //should be false - deny building towers
  bool oob = false; //detect when drop location is out of bounds, also deny building towers (out of bounds)
  late final CameraComponent cam;
  var world = Level1b();
  PauseButton pauseButton = PauseButton();
  DoforsChooser doforsChooser = DoforsChooser();
  QffhChooser qffhChooser = QffhChooser();
  AutoChooser autoChooser = AutoChooser();
  ModChooser modChooser = ModChooser();
  late final NoBuildWarning noBuildWarning = NoBuildWarning();
  late final BalanceShower balanceShower = BalanceShower(newBal: 0);
  int past = 0;
  int fornowBalance = 0; //balance
  int gameBill = 0;
  bool isPaused = false;
  bool isOnSelect = true;
  bool isOver=false; //flag for game over

  @override
  FutureOr<void> onLoad() async{
    saves = await SharedPreferences.getInstance();
    stageWin = saves.getBool('level1BCleared') ?? false;
    fornowBalance = saves.getInt('balance')??0;
    print(fornowBalance);

    cam = CameraComponent.withFixedResolution(
      world: world, width: 768, height: 384);
    cam.viewfinder.anchor = Anchor.topLeft;
    balanceShower.updateBalance(gameBill, fornowBalance);
    world.add(balanceShower);
    addAll([cam,world,pauseButton,doforsChooser,qffhChooser,autoChooser,modChooser]);
    
    overlays.add('ButtonHandler');    
  }

  void doforsDraggerFactory(){
    world.add(DoforsDragger()); //Add a draggable Bofors
  }

  void qffhDraggerFactory(){
    world.add(QffhDragger()); //Add a draggable QF 4.5
  }

    void autoDraggerFactory(){
    world.add(AutoDragger()); //Add a draggable QF 4.5
  }

  void modDraggerFactory(){
    world.add(ModDragger());
  }

  Future<void> doforsBulletFactory(Vector2 dofors, SpriteComponent target) async {
    
    world.add(BulletDofors(turretPos: dofors, bulletTarget: target));
  }

    Future<void> qffhBulletFactory(Vector2 qffh, SpriteComponent target) async {
    
    world.add(BulletQffh(turretPos: qffh, bulletTarget: target));
  }

  Future<void> autoBulletFactory(Vector2 auto, SpriteComponent target) async {
    
    world.add(BulletAuto(turretPos: auto, bulletTarget: target));
  }

    Future<void> modBulletFactory(Vector2 mod, SpriteComponent target) async {
    
    world.add(BulletMod(turretPos: mod, bulletTarget: target));
  }

  Future<void> doforsPlacer(Vector2 dropPos) async { //drop a final Bofors into the world - dropPos, position of drop
    noBuild(dropPos);
    if(notBuilding == false && oob == false){
      if(gameBill+500 < fornowBalance){
        gameBill = gameBill + 500;
        balanceShower.updateBalance(gameBill, fornowBalance);
        world.add(balanceShower);
        world.add(Dofors(dropPos));
      }else{
        fundWarning();
      }

    }else{
      if(notBuilding == true){ //handles no building in the map
       pathWarning();
     }
      if(oob == true){
       oobWarning();
      }
    }
  }

    Future<void> qffhPlacer(Vector2 dropPos) async { //drop a final QF into the world - dropPos, position of drop
    noBuild(dropPos);
    if(notBuilding == false && oob == false){
      if(gameBill+1000 < fornowBalance){
        gameBill = gameBill + 1000;
        balanceShower.updateBalance(gameBill, fornowBalance);
        world.add(balanceShower);
        world.add(Qffh(dropPos));
      }else{
        fundWarning();
      }

    }else{
      if(notBuilding == true){ //handles no building in the map
       pathWarning();
     }
      if(oob == true){
       oobWarning();
      }
    }
  }

      Future<void> autoPlacer(Vector2 dropPos) async { //drop a final QF into the world - dropPos, position of drop
    noBuild(dropPos);
    if(notBuilding == false && oob == false){
      if(gameBill+1500 < fornowBalance){
        gameBill = gameBill + 1500;
        balanceShower.updateBalance(gameBill, fornowBalance);
        world.add(balanceShower);
        world.add(Auto(dropPos));
      }else{
        fundWarning();
      }

    }else{
      if(notBuilding == true){ //handles no building in the map
       pathWarning();
     }
      if(oob == true){
       oobWarning();
      }
    }
  }

      Future<void> modPlacer(Vector2 dropPos) async { //drop a final QF into the world - dropPos, position of drop
    noBuild(dropPos);
    if(notBuilding == false && oob == false){
      if(gameBill+2000 < fornowBalance){
        gameBill = gameBill + 2000;
        balanceShower.updateBalance(gameBill, fornowBalance);
        world.add(balanceShower);
        world.add(Mod(dropPos));
      }else{
        fundWarning();
      }

    }else{
      if(notBuilding == true){ //handles no building in the map
       pathWarning();
     }
      if(oob == true){
       oobWarning();
      }
    }
  }

  Future<void> fundWarning() async {
        world.add(noBuildWarning);
        noBuildWarning.updateNoBuild("You lack the funds for this tower!");
        await Future.delayed(Duration(seconds: 2));
        noBuildWarning.updateNoBuild("");
  }
  Future<void> pathWarning() async {
        world.add(noBuildWarning);
        noBuildWarning.updateNoBuild("Don't build towers on paths!");
        await Future.delayed(Duration(seconds: 2));
        noBuildWarning.updateNoBuild("");
  }
  
  Future<void> oobWarning() async {
     world.add(noBuildWarning);
        noBuildWarning.updateNoBuild("Don't build towers outside of the map!");
        await Future.delayed(Duration(seconds: 2));
        noBuildWarning.updateNoBuild("");
  }

  void pauseGame() {
    
    if(isOver==false){
      //print("not over");
      if (isPaused) {
      print("resumed");
      isPaused = false;
      resumeEngine();
      } else {
      print("paused");
      isPaused = true;
      pauseEngine();
      }
    }
  }
  void endGame(){ //end the game, and lock the unpause function
    pauseEngine();
    isOver = true;
    print("over");
  }

  void unJam(){
    isOver = false;
    print("This is unjammer $isOver");
  }

  void noBuild(Vector2 dropPos){
    notBuilding = false;
    oob = false;
    print("finding dropPos");
    print(dropPos);
    if(dropPos.x > 90 && dropPos.x <= 350 && dropPos.y >270 && dropPos.y <375){
      print("w1 violation");
      notBuilding = true;
    }
    if(dropPos.x > 270 && dropPos.x <355 && dropPos.y > 220 && dropPos.y <300){
      print("w2 violation");
      notBuilding = true;
    }
    if(dropPos.x > 300 && dropPos.x <335 && dropPos.y > 145 && dropPos.y <270){
      print("w3 violation");
      notBuilding = true;
    }
    if(dropPos.x > 170 && dropPos.x < 300 && dropPos.y > 140 && dropPos.y < 200){
      print("w4 violation");
      notBuilding=true;
    }
    if(dropPos.x > 155 && dropPos.x < 185 && dropPos.y > 30 && dropPos.y < 195){
      print("w5 violation");
      notBuilding=true;
    }
    if(dropPos.x > 185 && dropPos.x < 435 && dropPos.y > 30 && dropPos.y < 100){
      print("w6 violation");
      notBuilding=true;
    }
    if(dropPos.x > 370 && dropPos.x < 435 && dropPos.y > 95 && dropPos.y < 225){
      print("w7 violation");
      notBuilding=true;
    }
    if(dropPos.x > 370 && dropPos.x < 495 && dropPos.y > 180 && dropPos.y < 225){
      print("w8 violation");
      notBuilding=true;
    }
    if(dropPos.x > 435 && dropPos.x < 485 && dropPos.y > 194 && dropPos.y < 320){
      print("w9 violation");
      notBuilding=true;
    }
    if(dropPos.x > 450 && dropPos.x < 620 && dropPos.y > 250 && dropPos.y < 330){
      print("w10 violation");
      notBuilding=true;
    }
    if(dropPos.x > 555 && dropPos.x < 625 && dropPos.y > 60 && dropPos.y < 320){
      print("w11 violation");
      notBuilding=true;
    }
    if(dropPos.x > 555 && dropPos.x <780 && dropPos.y >30 && dropPos.y <100){
      print("w12 violation");
      notBuilding=true;
    }
    if(dropPos.x<130){
      print("out of bounds");
      oob=true;
    }
  }
  void onWin(){
    //print("trying to save the win ");
    stageWin = true;
    saves.setBool('level1BCleared',stageWin);
    fornowBalance = fornowBalance - gameBill;
    saves.setInt('balance', fornowBalance);
    //saves.setInt('balance', balance);
  }
}