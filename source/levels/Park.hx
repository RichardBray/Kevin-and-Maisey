package levels;

import states.FullscreenText;
import flixel.tweens.FlxTween;
import states.LevelState;
import flixel.FlxState;
import flixel.FlxG;


class Park extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;

  public function new(firstPass:Bool = false) {
    super();
  }

  override public function create() {
    super.create();

    // Add bg
    if (_firstPass) addBackground();
    
    // Add characters (start offscreen)
    addKevin(-320, 655); 
    addMaisey(-140, 590); 
    
    // Add hud
    addHud();
    hud.alpha = 0;

    // Fullscreen texts
    if (!_firstPass) showFirstText();     

    // Players move on scene start
    FlxTween.tween(maisey, {x: 900}, 3);
    FlxTween.tween(kevin, {x: 630}, 2.5);

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;   
    maisey.playFlying = true; 
    
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
  }
}