package levels;

import states.LevelState;
import flixel.FlxState;
import flixel.FlxG;


class Park extends LevelState {
  public function new() {
    super();
  }

  override public function create() {
    super.create();

    // Add bg
    addBackground();
    
    // Add characters
    addKevin(480, 655); 
    addMaisey(0, 0); 
    
    // Add hud
    addHud();

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;    
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}