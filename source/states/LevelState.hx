package states;

import flixel.FlxSprite;
import flixel.FlxState;

class LevelState extends FlxState {
  public var maisey:FlxSprite;
  
  override public function create() {
    bgColor = 0xffffffff; // Game background color

  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}