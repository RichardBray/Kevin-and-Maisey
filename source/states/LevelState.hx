package states;

import flixel.FlxObject;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenCallback;
import utils.Constants;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

import characters.Maisey;
import characters.Kevin;
import components.Hud;

typedef SpeechData = { x:Float, y:Float, text:String, timing:Int };

class LevelState extends GameState {
  var _pauseMenu:PauseState;

  public var maisey:Maisey;
  public var kevin:Kevin;
  public var hud:Hud;
  public var floor:FlxObject;
  public var speech:FlxText;
  public var bg:FlxSprite;
  /** Prevents overlaps when Maisy needs to fly somwhere for cutscene */
  public var inCutScene:Bool = false;
  public var selectedItem:String = ""; // Tells state what item is selected

  override public function create() {
    super.create();
    bgColor = 0xffffffff; // Game background color

    floor = new FlxObject(0, 810, FlxG.width, 200);
    add(floor);        
  }

  public function addSpeech() {
    speech = new FlxText(0, 0, 500);
    speech.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK);
    speech.alpha = 0;
    add(speech);
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
    hud = new Hud(maisey, updateSelectedItem);
    add(hud);
  }

  public function addBackground() {
    bg = new FlxSprite(0, 0);
    bg.loadGraphic("assets/images/backgrounds/park.png", false, FlxG.width, FlxG.height);
    add(bg);
  }

  public function showSpeech(sentences:Array<SpeechData>, callback:Null<Void->Void>) {
    var sentenceIdx:Int = 0;
    for (sentence in sentences) {
      haxe.Timer.delay(() -> {
        sentenceIdx++;
        speech.setPosition(sentence.x, sentence.y);
        speech.applyMarkup(sentence.text, Constants.fontFormatting);
        speech.alpha = 1;     

        if (sentenceIdx == sentences.length) callback();        
      }, sentence.timing);
    }
  }

  public function updateSelectedItem(item:String) {
    selectedItem = item;
  }

  public function createHelpText(helpText:String):FlxText {
    var helpComp:FlxText = new FlxText(0, 343, 1200);
    helpComp.setFormat(Constants.rokkittRegular, Constants.lrgFont, FlxColor.BLACK, CENTER);
    helpComp.screenCenter(X);
    helpComp.applyMarkup(helpText, Constants.fontFormatting);
    helpComp.alpha = 0;
    return helpComp;
  }
  
  public function inCutScenePrep(callback:TweenCallback) {
    final cameraZoomVal:Float = 1.1;
    FlxTween.tween(FlxG.camera, {zoom: cameraZoomVal}, 0.2, {onComplete: callback});
  }

  public function outCutScenePrep(callback:TweenCallback) {
    FlxTween.tween(FlxG.camera, {zoom: 1}, 0.2, {onComplete: callback});
  }

  /**
   * Stops player character from moving down lower than the floor.
   */
  function preventPlayerDesent(maiseyCol:Maisey, floorCol:FlxSprite) {
    maiseyCol.isFloored = true;
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

    #if debug
    if (FlxG.mouse.justPressed) trace("Mouse pos:", FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
    #end
  
    // Maisey go to mouse click
    if (FlxG.mouse.justPressed && !maisey.preventMovement) {
      maisey.flyToPosition(FlxG.mouse.getPosition().x, FlxG.mouse.getPosition().y);
    }

    // Pause screen
		if (FlxG.keys.justPressed.ESCAPE) {
			var _pauseMenu:PauseState = new PauseState();
			openSubState(_pauseMenu);
    }  
    
    // Overlaps
    if (!inCutScene) {
      if (FlxG.overlap(maisey, floor)) {
        maisey.isFloored = true;
      } else {
        maisey.isFloored = false;
      }  
    }
  }
}