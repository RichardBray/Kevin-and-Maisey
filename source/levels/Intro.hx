package levels;

import components.FullscreenText;

import states.LevelState;

class Intro extends LevelState {
  var _intoFirstText:FullscreenText;

  override public function create() {
    super.create();
    
    // Add characters
    addKevin(400, 900);
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