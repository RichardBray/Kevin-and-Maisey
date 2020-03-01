package states;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

import characters.Maisey;
import characters.Kevin;
import components.Hud;

class LevelState extends GameState {
  public var maisey:Maisey;
  public var kevin:Kevin;
  public var hud:Hud;
  public var floor:FlxSprite;

  override public function create() {
    super.create();
    bgColor = 0xffefe1cb; // Game background color
  }

  public function addMaisey(x:Float = 0, y:Float = 0) {
    maisey = new Maisey(x, y);
    add(maisey);
  }

  public function addKevin(x:Float = 0, y:Float = 0) {
    kevin = new Kevin(x, y);
    add(kevin);
  } 
  
  public function addHud() {
    hud = new Hud(maisey);
    add(hud);
  }

  public function addFloor(height:Int, distanceFromTop:Int) {
    floor = new FlxSprite(0, distanceFromTop);
    floor.makeGraphic(FlxG.width, height, FlxColor.BLUE);
    add(floor);    
  }

  function preventPlayerDesent(maiseyCol:Maisey, floorCol:FlxSprite) {
    maiseyCol.isFloored = true;
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Maisey go to mouse click
    if (FlxG.mouse.justPressed && !maisey.preventMovement) {
      maisey.flyToPosition(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
    }

    if (FlxG.overlap(maisey, floor)) {
      maisey.isFloored = true;
      maisey.y = (900 - maisey.height) + 10; //TODO: remove + 10 when I get proper bg
    } else {
      maisey.isFloored = false;
    }
  }
}