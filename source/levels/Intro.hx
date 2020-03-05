package levels;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

import utils.Constants;
import characters.KevinEating;
import states.FullscreenText;
import states.LevelState;

class Intro extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;
  var _secondPass:Bool = false;
  var _maiseyIntroduced:Bool = false;
  var _kevinEating:KevinEating;

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
    kevin.alpha = _secondPass ? 1 : 0;
  
    _kevinEating = new KevinEating(400, 700);
    _kevinEating.alpha = _secondPass ? 0 : 1;
    add(_kevinEating);

    final maisyXPos:Int = _secondPass ? 1700 : 2000;
    addMaisey(maisyXPos, 600);
    maisey.faceLeft();
    
    // Add Hud
    addHud();

    // Help texts
    _helpTextOne = createHelpText("Click anywhere to move <maisey>Maisy<maisey> around");
    add(_helpTextOne);

    _helpTextTwo = createHelpText("Click on <kevin>Kevin<kevin> to talk to him.");
    add(_helpTextTwo);

    // Fullscreen texts
    if (!_firstPass) showFirstText(); 
    if (_firstPass && !_secondPass) introMaisy();
    
    // Help texts show
    if (_firstPass && _secondPass) {
      haxe.Timer.delay(() -> FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5), 500);
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
      new FullscreenText("and <maisey>Maisy<maisey>, Kevin's ladybird carer.", "Intro", 
      [true, true])
    );
  }

  function introMaisy() {
    haxe.Timer.delay(() -> {
      FlxTween.tween(maisey, {x: 1700}, 0.5, {
        onComplete: (_) -> { 
          haxe.Timer.delay(() -> _maiseyIntroduced = true, 500);
        },
        ease: FlxEase.circOut
      }); 
    }, 5500);
  }

  override public function mainCharactersInteract(_, _) {
    maisey.preventMovement = true;
    FlxTween.tween(maisey, {x: 840}, 0.5);
    FlxTween.tween(maisey, {x: 676}, 0.5);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_maiseyIntroduced) showSecondText();

    if (_seconds > 6) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
    if (_seconds > 8) FlxTween.tween(_helpTextTwo, {alpha: 1}, 0.5);
  }
}