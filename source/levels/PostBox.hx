package levels;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import states.FullscreenText;

import states.LevelState;

class PostBox extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;

  // Timings
  final _kevinStopsMoving:Float = 4;
  final _maiseyStopsMoving:Float = 4.2;  
  
  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
  }

  override public function create() {
    super.create();

    // Add bg
    if (_firstPass) addBackground(); 
    
    // Add characters (start offscreen)
    addKevin(-320, 655); 
    addMaisey(-140, 590);
    
    // Fullscreen texts
    if (!_firstPass) showFirstText();  
    
    // Players move on scene start
    FlxTween.tween(maisey, {x: 1120}, _maiseyStopsMoving);
    FlxTween.tween(kevin, {x: 630}, _kevinStopsMoving);  
    
    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;   
    maisey.isFlying = true;
    kevin.isListening = true;    
  }

  function showFirstText() {
    FlxG.switchState(new FullscreenText("Getting things done", "PostBox", [true]));
  }  

	function fadeOut() {
		FlxG.cameras.fade(FlxColor.WHITE, 0.5, false, changeState);
  }  
  
	function changeState() {
		FlxG.switchState(new BusStop());
  }    

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations
  }
}