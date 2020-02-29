package;

import flixel.FlxGame;
import levels.Intro;
import openfl.display.Sprite;

class Main extends Sprite {
	public function new() {
		super();
		addChild(new FlxGame(1920, 1080, Intro, 1, 60, 60, true));
	}
}
