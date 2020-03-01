package characters;


import flixel.util.FlxColor;
import flixel.FlxSprite;

class Kevin extends FlxSprite {
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    makeGraphic(300, 250, FlxColor.GREEN);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}