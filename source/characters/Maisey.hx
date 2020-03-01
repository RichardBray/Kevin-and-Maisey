package characters;

import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Maisey extends FlxSprite {
	var _min:FlxPoint;
  var _max:FlxPoint;

  public var preventMovement:Bool = false;
    
  public function new(x:Float = 0, y:Float = 0) {
    super(x, y);

		_min = FlxPoint.get(FlxG.width * 0.1, FlxG.height * 0.25);
    _max = FlxPoint.get(FlxG.width * 0.7, FlxG.height * 0.75);
      
    makeGraphic(50, 50, FlxColor.RED);
  }

  public function flyToPosition(destX:Float, destY:Float) {
    final duration:Float = ((Math.abs(x - destX) + Math.abs(y - destY)) / 1000);
    final minDuration:Float = (duration > .5) ? duration : .5;

    FlxTween.linearMotion(
      this, x, y, 
      (destX - (width / 2)), (destY - (height/2)), 
      minDuration, true, 
      { ease: FlxEase.sineIn }
    );
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
  }
}