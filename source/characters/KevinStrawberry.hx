package characters;

import flixel.FlxSprite;

class KevinStrawberry extends FlxSprite {
  public var isEating:Bool = false;

  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    loadGraphic("assets/images/characters/kevin_strawberry.png", true, 446, 201);

    animation.add("eating", [for (i in 0...72) i], 12, false);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (isEating) animation.play("eating");
  }
}