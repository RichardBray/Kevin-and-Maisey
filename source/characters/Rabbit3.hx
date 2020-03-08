package characters;

import flixel.FlxSprite;

class Rabbit3 extends FlxSprite {
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);
    loadGraphic("assets/images/characters/rabbit3.png", true, 282, 338);
    animation.add("talking", [for (i in 0...12) i], 8, true);	    
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    animation.play("talking");
  }
}