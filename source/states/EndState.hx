package states;


import utils.Constants;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;

class EndState extends GameState {
  var _seconds:Float = 0;
  var _logo:FlxSprite;
  var _startText:FlxText;
  var _mainText:FlxText;

  public function new() {
    super();     
  }

  override public function create() {
    super.create();

		FlxG.sound.playMusic("assets/music/theme.ogg", 0.4, false);	
    FlxG.sound.music.persist = true;
      
    // Main text
    _mainText = new FlxText(0, 0, 500);
    _mainText.setFormat(Constants.rokkittRegular, Constants.lrgFont, FlxColor.BLACK, CENTER);
    _mainText.screenCenter(XY);
    _mainText.applyMarkup("Thanks for playing", Constants.fontFormatting);
    add(_mainText);
          
    // Sub text
    _startText = new FlxText(0, FlxG.height - 100, 0, "Click anywhere to Restart");
    _startText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _startText.screenCenter(X);
    add(_startText);      
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed;
    if (FlxG.mouse.justPressed) FlxG.switchState(new states.StartState());
  }
}