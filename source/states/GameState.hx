package states;

import flixel.FlxState;
import flixel.FlxG;

class GameState extends FlxState {
  override public function create() {
    FlxG.autoPause = false; // Prevent flixel autopause screen
  }
}