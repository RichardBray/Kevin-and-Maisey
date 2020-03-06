package characters;

import flixel.FlxSprite;

class KevinEating extends FlxSprite {
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    loadGraphic("assets/images/characters/kevin_eating.png", true, 446, 201);

    animation.add("eating", [for (i in 0...107) i], 14, false);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    animation.play("eating");
  }
}