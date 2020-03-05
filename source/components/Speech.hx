package components;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

class Speech extends FlxSpriteGroup {
  var _text: String = "";
  var _character:FlxSprite;

  public function new(character:FlxSprite) {
    super();
    
    _character = character;
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}