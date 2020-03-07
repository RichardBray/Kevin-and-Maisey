package characters;


import flixel.util.FlxColor;
import flixel.FlxSprite;

class Kevin extends FlxSprite {
  public var isWalking:Bool = false;
  public var isIdle:Bool = false;

  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    loadGraphic("assets/images/characters/kevin.png", true, 310, 166);

    animation.add("idle", [33], 12);	
    animation.add("walking", [for (i in 0...10) i], 12);	
    animation.add("outShell", [for (i in 16...31) i], 12);
    animation.add("inShell", [for (i in 32...48) i], 12);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (isWalking) {
      animation.play("walking");
    } else if (isIdle) {
      animation.play("idle");
    }
  }
}