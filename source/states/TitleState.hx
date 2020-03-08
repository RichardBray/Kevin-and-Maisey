package states;


import utils.Constants;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class TitleState extends GameState {
  var _seconds:Float = 0;
  var _logo:FlxSprite;
  var _startText:FlxText;

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
    _startText = new FlxText(0, FlxG.height - 100, 0, "Click anywhere to Start");
    _startText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _startText.screenCenter(X);
    add(_startText);      
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed;
    if (FlxG.mouse.justPressed) FlxG.switchState(new levels.Intro());
  }
}