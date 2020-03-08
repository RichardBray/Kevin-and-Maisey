package states;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;

class GameState extends FlxState {
  override public function create() {
    FlxG.autoPause = false; // Prevent flixel autopause screen
    FlxG.camera.antialiasing = true;
  }

	public function centerImage(image:FlxSprite) {
		image.x = (FlxG.width / 2) - (image.width / 2);
		image.y = (FlxG.height / 2) - (image.height / 2);
	}  
}