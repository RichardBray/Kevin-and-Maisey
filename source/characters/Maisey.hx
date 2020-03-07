package characters;

import flixel.FlxObject;
import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class Maisey extends FlxSprite {
	var _min:FlxPoint;
  var _max:FlxPoint;
  var _isMoving:Bool = false;
  var _destX:Float = 0; // Used to determine if player is moving
  var _destY:Float = 0; // Used to fix hack for player height

  public var isIdle:Bool = false;
  public var preventMovement:Bool = false;
  public var isFloored:Bool = false;
  public var isFlying:Bool = false;
    
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

    _destX = x - (132 / 2);
		_min = FlxPoint.get(FlxG.width * 0.1, FlxG.height * 0.25);
    _max = FlxPoint.get(FlxG.width * 0.7, FlxG.height * 0.75);
      
    loadGraphic("assets/images/characters/maisy.png", true, 132, 141);

		setFacingFlip(FlxObject.LEFT, true, false);
    setFacingFlip(FlxObject.RIGHT, false, false);  
    
    animation.add("run", [for (i in 0...6) i], 12);	
    animation.add("takeOff", [for (i in 10...13) i], 12);	
    animation.add("idle", [for (i in 20...29) i], 4);	
    animation.add("flying", [for (i in 30...37) i], 12);	
  }

  public function flyToPosition(destX:Float, destY:Float) {
    final minTravelTime:Float = 0.4;
    final duration:Float = ((Math.abs(x - destX) + Math.abs(y - destY)) / 1000);
    final minDuration:Float = (duration > minTravelTime) ? duration : minTravelTime;

    // Used to check if player is moving for run animation
    _destX = destX;
    _destY = destY;

    // Detect if player is moving to play run animation when floored
    if (x != destX) _isMoving = true;

    // Change direction pased on movement
    facing = ((x - destX) < 0) ? FlxObject.RIGHT : FlxObject.LEFT;
  
    FlxTween.linearMotion(
      this, x, y, 
      (destX - (width / 2)), (destY - (height / 2)), 
      minDuration, true, 
      { ease: FlxEase.sineIn }
    );
  }

  public function faceLeft() {
    facing = FlxObject.LEFT;
  }

  public function faceRight() {
    facing = FlxObject.RIGHT;
  }  

  override public function update(elapsed:Float) {
    super.update(elapsed);
    final isMoving:Bool = x != (_destX - (width / 2));
  
    if (!preventMovement) {
      if (isFloored) {
        animation.play(isMoving ? "run" : "idle");
        if (_destY > (808 + height)) {
          y = isMoving ? 689 : 679; // hack to fix incorrect spritesheet height
        }
      } else {
        animation.play("flying");
      }
    } else {
      if (isIdle) {
        animation.play("idle");
        y = 679;
      } else if (isFlying) {
        animation.play("flying");
      } else {
        animation.play("run");
      }
    }
  }
}