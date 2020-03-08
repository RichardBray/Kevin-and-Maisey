package characters;

import flixel.FlxSprite;

class Rabbit1 extends FlxSprite {
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);
    loadGraphic("assets/images/characters/rabbit1.png", true, 158, 101);
    animation.add("sleeping", [for (i in 0...9) i], 4, true);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    animation.play("sleeping");
  }
}