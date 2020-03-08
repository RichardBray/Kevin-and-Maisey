package characters;

import flixel.FlxObject;
import flixel.FlxSprite;

class Kevin extends FlxSprite {
  public var isWalking:Bool = false;
  public var isIdle:Bool = false;
  public var isInShell:Bool = false;
  public var isInShellIdle:Bool = false;
  public var isListening:Bool = false;
  public var isNodding:Bool = false;

  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    loadGraphic("assets/images/characters/kevin.png", true, 310, 199);

    animation.add("idle", [for (i in 0...9) i], 12);	
    animation.add("nodding", [for (i in 16...20) i], 12);	
    animation.add("walking", [for (i in 32...42) i], 12);
    animation.add("listening", [for (i in 48...58) i], 12);
    animation.add("inShell", [for (i in 64...79) i], 12);	
    animation.add("inShellIdle", [79], 12);	    	
    animation.add("outShell", [for (i in 80...95) i], 12);

		setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);     
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (isWalking) {
      animation.play("walking");
    } else if (isIdle) {
      animation.play("idle");
    } else if (isInShell) {
      animation.play("inShell");
    } else if (isInShellIdle) {
      animation.play("inShellIdle");
    } else if (isListening) {
      animation.play("listening");
    } else if (isNodding) {
      animation.play("nodding");
    }
  }
}