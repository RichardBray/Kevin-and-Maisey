package characters;

import flixel.FlxSprite;

class Rabbit2 extends FlxSprite {
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);
    loadGraphic("assets/images/characters/rabbit2.png", true, 172, 355);
    animation.add("moving", [for (i in 0...41) i], 8, true);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    animation.play("moving");
  }
}