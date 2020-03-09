package states;

import openfl.system.System;
import utils.Constants;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;

class TitleState extends GameState {
  var _seconds:Float = 0;
  var _logo:FlxSprite;
  var _startText:FlxText;
  var _closeGameText:FlxText;

  public function new() {
    super();     
  }

  override public function create() {
    super.create();
		bgColor = FlxColor.WHITE;
		FlxG.cameras.fade(bgColor, 0.5, true); // Level fades in
		_logo = new FlxSprite(0, 0);
		_logo.loadGraphic("assets/images/logos/mak.png", false, 535, 239);
		centerImage(_logo);
    add(_logo);
        
    // Sub text
    _startText = new FlxText(0, FlxG.height - 200, 0, "Start Game");
    _startText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _startText.screenCenter(X);
    add(_startText);   
    
    _closeGameText = new FlxText(0, FlxG.height - 150, 0, "Quit to Desktop");
    _closeGameText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _closeGameText.screenCenter(X);
    #if !html5
    add(_closeGameText);
    #end     
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed;

    if (FlxG.mouse.overlaps(_startText)) {
      _startText.alpha = 0.5;
      if (FlxG.mouse.justPressed) {
        FlxG.sound.music.stop();
        FlxG.switchState(new levels.Intro());
      }
    } else {
      _startText.alpha = 1;
    }

    if (FlxG.mouse.overlaps(_closeGameText)) {
      _closeGameText.alpha = 0.5;
      if (FlxG.mouse.justPressed) System.exit(0);
    } else {
      _closeGameText.alpha = 1;
    }

  }
}