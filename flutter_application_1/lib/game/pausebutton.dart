import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter_application_1/game/gameself.dart';
import 'package:flutter/material.dart';

class PauseButton extends SpriteComponent with TapCallbacks, HasGameRef<GameSelf> {
  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('pauseT.png');
    anchor = Anchor.center;
    size = Vector2(30, 30); // Set the size of your button
    position = Vector2(20, 60); // Position it accordingly
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    gameRef.pauseGame(); // Custom method in your game class to handle pausing
  }
}