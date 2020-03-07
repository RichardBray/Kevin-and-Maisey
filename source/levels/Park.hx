package levels;

import flixel.text.FlxText;
import states.FullscreenText;
import flixel.tweens.FlxTween;
import states.LevelState;
import flixel.FlxState;
import flixel.FlxG;


class Park extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;

  var _helpTextOne:FlxText;

  // Timings
  final _kevinStopsMoving:Float = 4;
  final _maiseyStopsMoving:Float = 4.2;
  var _openHelpOne:Float = 0;
  var _closeHelpOne:Float = 0;

  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _openHelpOne = _maiseyStopsMoving + 2;
    _closeHelpOne = _openHelpOne + 7;
  }

  override public function create() {
    super.create();

    // Add bg
    if (_firstPass) addBackground();

    // Help texts
    _helpTextOne = createHelpText(
      "You will often have to read Kevin’s body language to help decide what is best. 
      Save objects to use later, they might come in handy to resolve stressful situations.");
    add(_helpTextOne);
    
    // Add characters (start offscreen)
    addKevin(-320, 655); 
    addMaisey(-140, 590); 
    
    // Add hud
    addHud();
    hud.alpha = 0;

    // Fullscreen texts
    if (!_firstPass) showFirstText();     

    // Players move on scene start
    FlxTween.tween(maisey, {x: 1120}, _maiseyStopsMoving);
    FlxTween.tween(kevin, {x: 630}, _kevinStopsMoving);

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;   
    maisey.isFlying = true;
    kevin.isWalking = true;
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("They walked for a few minutes and then...", "Park", 
      [true])
    );
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_seconds > _kevinStopsMoving && _seconds < 5) {
      kevin.isWalking = false;
      kevin.isIdle = true;
    }

    if (_seconds > (_maiseyStopsMoving + 1) && _seconds < _openHelpOne) maisey.faceLeft();
    if (_seconds > _openHelpOne && _seconds < _closeHelpOne)  {
      FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5);
      hud.alpha = 1;
      inCutScene = false; 
      maisey.preventMovement = false;
    }
    if (_seconds > _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
  }
}