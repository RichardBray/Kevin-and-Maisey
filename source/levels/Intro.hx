package levels;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

import utils.Constants;
import characters.KevinEating;
import states.FullscreenText;
import states.LevelState;

import states.LevelState.SpeechData;
class Intro extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;
  var _maiseyIntroduced:Bool = false;
  var _kevinEating:KevinEating;

  var _helpTextOne:FlxText;
  var _helpTextTwo:FlxText;
  var _helpTextThree:FlxText;
  var _helpTextFour:FlxText;  

  var _charactersLeaving:Bool = false;
  var _charactersTallking:Bool = false;

  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
  }

  override public function create() {
    super.create();
  
    // Environment
    addFloor(200, 900);

    // Add characters
    addKevin(500, 720);
    kevin.alpha = 0;
  
    _kevinEating = new KevinEating(400, 700);
    _kevinEating.alpha = 1;
    add(_kevinEating);

    addMaisey(2000, floor.y - (141 - 10));
    maisey.isFloored = true;
    maisey.faceLeft();
    
    // Add Hud
    addHud();

    // Help texts
    _helpTextOne = createHelpText("<kevin>Kevin<kevin> struggles with anxiety and often finds it hard to communicate");
    add(_helpTextOne);

    _helpTextTwo = createHelpText(
      "This is <maisey>Maisy<maisey>, <kevin>Kevin’s<kevin> carer and
      friend. <kevin>Kevin<kevin> trusts Maisy and feels very comfortable with her by his side.");
    add(_helpTextTwo);

    _helpTextThree = createHelpText("Play as <maisey>Maisy<maisey>. Use your tool kit to help <kevin>Kevin<kevin> navigate through day to day activities and cope in times of anxiety. ");
    add(_helpTextThree);    

    _helpTextFour = createHelpText("Click anywhere on the screen to move <maisey>Maisy<maisey>. ");
    add(_helpTextFour);  


    // Kevin trusts Maisy and feels very comfortable with her by his side.

    // Fullscreen texts
    if (!_firstPass) showFirstText(); 
    
    // Help texts show
    haxe.Timer.delay(() -> FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5), 500);  

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;
  }

  function createHelpText(helpText:String):FlxText {
    var helpComp:FlxText = new FlxText(0, 60, 500);
    helpComp.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    helpComp.screenCenter(X);
    helpComp.applyMarkup(helpText, Constants.fontFormatting);
    helpComp.alpha = 0;
    return helpComp;
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("Meet <kevin>Kevin<kevin>", "Intro", 
      [true])
    );
  }

  function introMaisy() {
    FlxTween.tween(maisey, {x: 1400}, 3, {
      onComplete: (_) -> _maiseyIntroduced = true
    }); 
  }

  function charactersTalk(_) {
    final maisyPos:Array<Int> = [850, 700];
    final sentences:Array<SpeechData> = [
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nMorning Kevin!", timing: 0
      },
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nWow you ate your breakfast quickly.", timing: 2500
      },
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nWant to come to the post office with me?", timing: 4500
      },
      {
        x: maisyPos[0] - 20, y: maisyPos[1], text: "<kevin>Kevin<kevin>\nYes", timing: 7500
      },
      {
        x: 0, y: 0, text: "", timing: 9000
      }              
    ];

    _charactersTallking = true;

    if (!_charactersLeaving) {
      FlxTween.tween(_helpTextFour, {alpha: 0}, 0.5);  
      showSpeech(sentences, () -> outCutScenePrep(charactersLeaveScene));
    }
  }

  function charactersLeaveScene(_) {
    _charactersLeaving = true;
    speech.alpha = 0;
    FlxTween.tween(kevin, {x: 2000}, 6);
    FlxTween.tween(maisey, {x: 2000}, 5);
  }

  override public function mainCharactersInteract(_, _) {
    maisey.preventMovement = true;
    FlxTween.tween(maisey, {x: 985, y: 700}, 0.5);
    maisey.faceLeft();
    haxe.Timer.delay(() -> inCutScenePrep(charactersTalk), 500);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_charactersLeaving) kevin.kevinWalking = true;

    if (_seconds > 3 && _seconds < 10) introMaisy();      
    if (_seconds > 3) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
    if (_seconds > 6 && _seconds < 10) FlxTween.tween(_helpTextTwo, {alpha: 1}, 0.5);
    if (_seconds > 7.65) {
      _kevinEating.alpha = 0;
      kevin.alpha = 1;
    }
    if (_maiseyIntroduced) maisey.playIdle = true;
    if (_seconds > 10) FlxTween.tween(_helpTextTwo, {alpha: 0}, 0.5);
    if (_seconds > 12 && _seconds < 16) FlxTween.tween(_helpTextThree, {alpha: 1}, 0.5);
    if (_seconds > 18) FlxTween.tween(_helpTextThree, {alpha: 0}, 0.5);
    if (_seconds > 20 && !_charactersTallking) {
      FlxTween.tween(_helpTextFour, {alpha: 1}, 0.5);
      maisey.preventMovement = false;   
      inCutScene = false;   
    }
  }
}