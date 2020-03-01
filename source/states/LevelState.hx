package states;

import flixel.FlxG;

import characters.Maisey;
import characters.Kevin;
import components.Hud;

class LevelState extends GameState {
  public var maisey:Maisey;
  public var kevin:Kevin;
  public var hud:Hud;

  override public function create() {
    super.create();
    bgColor = 0xffffffff; // Game background color
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

  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Maisey go to mouse click
    if (FlxG.mouse.justPressed && !maisey.preventMovement) {
      maisey.flyToPosition(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
    }
  }
}