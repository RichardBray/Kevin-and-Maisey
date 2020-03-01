package levels;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import components.FullscreenText;

import states.LevelState;

class Intro extends LevelState {
  var _intoFirstText:FullscreenText;
  var _floor:FlxSprite;

  override public function create() {
    super.create();
  
    // Environment
    addFloor(200, 900);

    // Add characters
    addKevin(400, 700);
    addMaisey(40, 40);
    
    // Add Hud
    addHud();

    // Fullscreen texts NEED TO BE AT BOTTOM OF create()
    _intoFirstText = new FullscreenText("Some <kevin>test<kevin> Text", maisey);
    add(_intoFirstText);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Fullscreen text toggles
    !_intoFirstText.screenSeen ? _intoFirstText.show() : _intoFirstText.hide();
  }
}