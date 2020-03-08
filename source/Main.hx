package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		#if !debug
		addChild(new FlxGame(1920, 1080, levels.Intro, 1, 60, 60, true));
		#else 		
		addChild(new FlxGame(1920, 1080, levels.PostBox, 1, 60, 60, true));
		#end
	}
}
