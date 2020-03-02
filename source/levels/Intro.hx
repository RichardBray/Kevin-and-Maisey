package levels;

import flixel.util.FlxColor;
import utils.Constants;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import states.FullscreenText;
import states.LevelState;

class Intro extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;
  var _secondPass:Bool = false;
  var _maiseyIntroduced:Bool = false;

  var _helpTextOne:FlxText;

  public function new(firstPass:Bool = false, secondPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _secondPass = secondPass;
  }

  override public function create() {
    super.create();
  
    // Environment
    addFloor(200, 900);

    // Add characters
    addKevin(400, 700);
    final maisyXPos:Int = _secondPass ? 40 : -100;
    addMaisey(maisyXPos, 40);
    
    // Add Hud
    addHud();

    // Help texts
    _helpTextOne = new FlxText(0, 60, 500);
    _helpTextOne.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _helpTextOne.screenCenter(X);
    _helpTextOne.applyMarkup("Click anywhere to move <maisey>Maisy<maisey> around", Constants.fontFormatting);
    _helpTextOne.alpha = 0;
    add(_helpTextOne);

    // Fullscreen texts
    if (!_firstPass) showFirstText(); 
    if (_firstPass && !_secondPass) introMaisy(); 
    
    // Help texts show
    if (_firstPass && _secondPass) {
      // base this on second timings
      haxe.Timer.delay(() -> FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5), 500);
      // click bottom right tab to open and close your item section
      // click on and item to use it
    }    
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("Meet <kevin>Kevin<kevin>, the Kevin's helper.", "Intro", 
      [true])
    );
  }

  function showSecondText() {
    FlxG.switchState(
      new FullscreenText("Meet <maisey>Maisy<maisey>, the autistic turtle.", "Intro", 
      [true, true])
    );
  }

  function introMaisy() {
    haxe.Timer.delay(() -> {
      FlxTween.tween(maisey, {x: 40}, 0.5, {
        onComplete: (_) -> { 
          haxe.Timer.delay(() -> _maiseyIntroduced = true, 500);
        },
        ease: FlxEase.circOut
      }); 
    }, 1000);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_maiseyIntroduced) showSecondText();
  }
}