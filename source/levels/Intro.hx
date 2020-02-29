package levels;

import flixel.util.FlxColor;
import utils.Constants;
import flixel.text.FlxText;

import states.LevelState;

class Intro extends LevelState {
  var _intoFirstText:FlxText;

  override public function create() {
    super.create();

    _intoFirstText = new FlxText(0, 0, 0, "Some test Text");
    _intoFirstText.setFormat(Constants.rokkittRegular, 33, FlxColor.BLACK, CENTER);
    _intoFirstText.screenCenter(XY);
    add(_intoFirstText);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}