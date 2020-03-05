package states;

import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

import characters.Maisey;
import characters.Kevin;
import components.Hud;

class LevelState extends GameState {
  var _pauseMenu:PauseState;

  public var maisey:Maisey;
  public var kevin:Kevin;
  public var kevinBox:FlxObject;
  public var hud:Hud;
  public var floor:FlxSprite;

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
    kevinBox = new FlxObject(x - 50, y - 50, kevin.width + 100, kevin.height + 100);
    add(kevin);
    add(kevinBox);
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

  /**
   * Stops player character from moving down lower than the floor.
   */
  function preventPlayerDesent(maiseyCol:Maisey, floorCol:FlxSprite) {
    maiseyCol.isFloored = true;
  }

  public function mainCharactersInteract(_, _) {
    // made to be ovewritten
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

    // Maisey go to mouse click
    if (FlxG.mouse.justPressed && !maisey.preventMovement) {
      js.Browser.console.log(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
      maisey.flyToPosition(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
    }

		if (FlxG.keys.justPressed.ESCAPE) {
			var _pauseMenu:PauseState = new PauseState();
			openSubState(_pauseMenu);
    }  
    
    // Overlaps

    FlxG.overlap(maisey, kevin, mainCharactersInteract);
    if (FlxG.overlap(maisey, floor)) {
      maisey.isFloored = true;
      maisey.y = (floor.y - maisey.height) + 10; //TODO: remove + 10 when I get proper bg
    } else {
      maisey.isFloored = false;
    }  
  }
}