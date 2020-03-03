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
  var _helpTextTwo:FlxText;

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
    _helpTextOne = createHelpText("Click anywhere to move <maisey>Maisy<maisey> around");
    add(_helpTextOne);

    _helpTextTwo = createHelpText("Click on the bottom right section to see your <strong>items<strong>");
    add(_helpTextTwo);

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

  function createHelpText(helpText:String):FlxText {
    var helpComp:FlxText = new FlxText(0, 60, 500);
    helpComp.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    helpComp.screenCenter(X);
    helpComp.applyMarkup(helpText, Constants.fontFormatting);
    helpComp.alpha = 0;
    return helpComp;
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("Meet <kevin>Kevin<kevin>, the autistic turtle.", "Intro", 
      [true])
    );
  }

  function showSecondText() {
    FlxG.switchState(
      new FullscreenText("Meet <maisey>Maisy<maisey>, Kevin's ladybird carer.", "Intro", 
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

    if (_seconds > 3) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
    if (_seconds > 5) FlxTween.tween(_helpTextTwo, {alpha: 1}, 0.5);
  }
}