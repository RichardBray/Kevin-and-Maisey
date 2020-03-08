package levels;

import flixel.FlxSprite;
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
  var _blueLine:FlxSprite;

  var _helpTextOne:FlxText;
  var _helpTextTwo:FlxText;
  var _helpTextThree:FlxText;
  var _helpTextFour:FlxText;  

  var _charactersLeaving:Bool = false;
  var _charactersTallking:Bool = false;

  // Text timings
  final _openHelpOne:Float = 4;
  var _closeHelpOne:Float = 0;
  var _openHelpTwo:Float = 0;
  var _closeHelpTwo:Float = 0;
  var _openHelpThree:Float = 0;
  var _closeHelpThree:Float = 0;
  var _openHelpFour:Float = 0;

  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _closeHelpOne = _openHelpOne + 7;
    _openHelpTwo = _closeHelpOne + 2;
    _closeHelpTwo = _openHelpTwo + 8;
    _openHelpThree = _closeHelpTwo + 2;
    _closeHelpThree = _openHelpThree + 8;  
    _openHelpFour = _closeHelpThree + 2;  
  }

  override public function create() {
    super.create();
  
    addSpeech();
  
    // Environment
    _blueLine = new FlxSprite(0, 820);
    _blueLine.makeGraphic(FlxG.width, 10, Constants.floorBlue);
    add(_blueLine);

    // Help texts
    _helpTextOne = createHelpText("<kevin>Kevin<kevin> struggles with anxiety and often finds it hard to communicate.");
    add(_helpTextOne);

    _helpTextTwo = createHelpText(
      "This is <maisey>Maisy<maisey>, <kevin>Kevin’s<kevin> carer and friend.
      <kevin>Kevin<kevin> trusts Maisy and feels very comfortable with her by his side.");
    add(_helpTextTwo);

    _helpTextThree = createHelpText("Play as <maisey>Maisy<maisey>.
    Help <kevin>Kevin<kevin> navigate through day-to-day activities and cope in times of anxiety.");
    add(_helpTextThree);    

    _helpTextFour = createHelpText("Click anywhere on the screen to move <maisey>Maisy<maisey>.");
    add(_helpTextFour);  


    // Add characters
    addKevin(480, 622);
    kevin.alpha = 0;
  
    _kevinEating = new KevinEating(400, 630);
    _kevinEating.alpha = 1;
    add(_kevinEating);

    addMaisey(2000, floor.y - (141 - 20));
    maisey.isFloored = true;
    maisey.faceLeft();

    // Fullscreen texts
    if (!_firstPass) showFirstText(); 
    
    // Help texts show
    haxe.Timer.delay(() -> FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5), Std.int(_openHelpOne * 1000));  

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("Meet Kevin", "Intro", 
      [true])
    );
  }

  function introMaisy() {
    FlxTween.tween(maisey, {x: 1290}, 3, {
      onComplete: (_) -> _maiseyIntroduced = true
    }); 
  }

  function charactersTalk(_) {
    final maisyPos:Array<Int> = [750, 450];
    final sentences:Array<SpeechData> = [
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nMorning Kevin!", timing: 0
      },
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nWow you ate your breakfast quickly.", timing: 2000
      },
      {
        x: maisyPos[0], y: maisyPos[1], text: "<maisey>Maisy<maisey>\nWant to come to the post office with me?", timing: 6000
      },
      {
        x: maisyPos[0] - 20, y: maisyPos[1], text: "<kevin>Kevin<kevin>\n...", timing: 9000
      },      
      {
        x: maisyPos[0] - 20, y: maisyPos[1], text: "<kevin>Kevin<kevin>\nOkay", timing: 11000
      },
      {
        x: maisyPos[0] - 20, y: maisyPos[1], text: "", timing: 12000
      }              
    ];

    if (!_charactersLeaving) {
      showSpeech(sentences, () -> outCutScenePrep(charactersLeaveScene));
    }
  }

  function charactersLeaveScene(_) {
    _charactersLeaving = true;
    speech.alpha = 0;
    maisey.faceRight();
    FlxTween.tween(kevin, {x: 2000}, 6);
    FlxTween.tween(maisey, {x: 2000}, 4);
  }

	function fadeOut() {
		FlxG.cameras.fade(FlxColor.WHITE, 0.5, false, changeState);
  }  
  
	function changeState() {
		FlxG.switchState(new Park());
	}  

  override public function mainCharactersInteract(_, _) {
    FlxTween.tween(_helpTextFour, {alpha: 0}, 0.5);  
    _charactersTallking = true;
    FlxTween.tween(maisey, {x: 1127, y: 590}, 0.5);
    maisey.faceLeft();
    maisey.isFlying = true;
    haxe.Timer.delay(() -> inCutScenePrep(charactersTalk), 500);
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_charactersLeaving) kevin.isWalking = true;

    if (_seconds > (_closeHelpOne + 2) && _seconds < (_closeHelpOne + 10)) introMaisy();      
    if (_seconds > (_closeHelpOne)) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
    if (_seconds > (_openHelpTwo) && _seconds < (_openHelpTwo + 4)) FlxTween.tween(_helpTextTwo, {alpha: 1}, 0.5);
    if (_seconds > (7.666)) {
      _kevinEating.alpha = 0;
      kevin.alpha = 1;
    }
    if (_maiseyIntroduced && _seconds < (_openHelpFour + 2)) maisey.isIdle = true;
    if (_seconds > (_closeHelpTwo)) FlxTween.tween(_helpTextTwo, {alpha: 0}, 0.5);
    if (_seconds > (_openHelpThree) && _seconds < (_openHelpThree + 4)) FlxTween.tween(_helpTextThree, {alpha: 1}, 0.5);
    if (_seconds > (_closeHelpThree)) FlxTween.tween(_helpTextThree, {alpha: 0}, 0.5);
    if (_seconds > (_openHelpFour) && _seconds < (_openHelpFour + 2)) {
      FlxTween.tween(_helpTextFour, {alpha: 1}, 0.5);
      FlxTween.tween(maisey, {y: 579}, 0.5);
      maisey.isIdle = false;
      maisey.isFlying = true;
      maisey.isFloored = false;
      inCutScene = false;         
    }
    if (_seconds > (_openHelpFour)) maisey.preventMovement = _charactersTallking;
    
    // End scene
    if (kevin.x == 2000) fadeOut();
  }
}