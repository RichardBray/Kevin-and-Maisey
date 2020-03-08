package levels;

import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.FlxG;

import states.FullscreenText;
import characters.KevinStrawberry;
import states.LevelState;

import states.LevelState.SpeechData;

class Park extends LevelState {

  var _seconds:Float = 0;
  var _eatSeconds:Float = 0; // seconds post feeding strawberry
  var _firstPass:Bool = false;

  var _kevinEating:KevinStrawberry;  
  var _helpTextOne:FlxText;

  var _sndGrowl:FlxSound;
  var _charactersLeaving:Bool = false;
  
  // Timings
  final _kevinStopsMoving:Float = 10;
  final _maiseyStopsMoving:Float = 8.2;
  var _openHelpOne:Float = 0;
  var _closeHelpOne:Float = 0;

  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _openHelpOne = _maiseyStopsMoving + 2;
    _closeHelpOne = _openHelpOne + 4;
  }

  override public function create() {
    super.create();

    FlxG.sound.playMusic("assets/music/birds.ogg", 0.5, true);
    FlxG.sound.music.persist = false;	

    _sndGrowl = FlxG.sound.load("assets/sounds/growl.ogg", 1);

    // Add bg
    if (_firstPass) addBackground();

    addSpeech();
  
    // Help texts
    _helpTextOne = createHelpText(
      "Uh oh <kevin>Kevin's<kevin> stomach is rumbling. Do you have any food?");
    add(_helpTextOne);
    
    // Add characters (start offscreen)
    addKevin(-320, 622); 
    addMaisey(-140, 590); 

    _kevinEating = new KevinStrawberry(600, 630);
    _kevinEating.alpha = 0;
    add(_kevinEating);    
    
    // Add hud
    addHud();
    hud.alpha = 0;

    // Fullscreen texts
    if (!_firstPass) showFirstText();     

    // Players move on scene start
    FlxTween.tween(maisey, {x: 1120}, _maiseyStopsMoving);
    FlxTween.tween(kevin, {x: 630}, _kevinStopsMoving);

    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;   
    maisey.isFlying = true;
    kevin.isWalking = true;
  }

  function showFirstText() {
    FlxG.switchState(
      new FullscreenText("5 minutes later..", "Park", 
      [true])
    );
  }

  function charactersTalk(_) {
    final speechPos:Array<Int> = [860, 430];
    final sentences:Array<SpeechData> = [
      {
        x: speechPos[0], y: speechPos[1], text: "<maisey>Maisy<maisey>\nFeeling better?", timing: 0
      },
      {
        x: speechPos[0], y: speechPos[1], text: "<kevin>Kevin<kevin>\nYes", timing: 2000
      },
      {
        x: speechPos[0], y: speechPos[1], text: "<maisey>Maisy<maisey>\nGreat, let's keep going, we're almost there.", timing: 3000
      },
      {
        x: speechPos[0], y: speechPos[1], text: "", timing: 7000
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
    kevin.isWalking = true;
    FlxTween.tween(kevin, {x: 2000}, 10);
    FlxTween.tween(maisey, {x: 2200}, 7);
  }  

	function fadeOut() {
		FlxG.cameras.fade(FlxColor.WHITE, 0.5, false, changeState);
  }  
  
	function changeState() {
		FlxG.switchState(new BusStop());
  }  
  
  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed; // Used for animations

    if (_seconds > _kevinStopsMoving && _seconds < 11) {
      kevin.isWalking = false;
      kevin.isIdle = true;
    }
    if (_seconds > _kevinStopsMoving && _seconds < (_kevinStopsMoving + 0.1)) _sndGrowl.play();

    if (_seconds > (_maiseyStopsMoving + 1) && _seconds < _openHelpOne) maisey.faceLeft();
    if (_seconds > _openHelpOne && _eatSeconds < 4.7)  {
      hud.alpha = 1;
      inCutScene = false; 
      maisey.preventMovement = false;
    }
    if (_seconds > _openHelpOne && _seconds < _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5);
    if (_seconds > _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);

    // Kevin eating strawberry
    if (_eatSeconds > 0) _eatSeconds += elapsed; // Start eat timer
    if (FlxG.mouse.overlaps(kevin) && FlxG.mouse.justPressed && selectedItem == "strawberry") {
      kevin.alpha = 0;
      _kevinEating.alpha = 1;
      _kevinEating.isEating = true;  
      _eatSeconds += elapsed;
      hud.hideHud();
      updateSelectedItem("");
    }

    // Cut screne
    if (_eatSeconds > 4.7) {
      kevin.alpha = 1;
      _kevinEating.alpha = 0;  
      maisey.preventMovement = true;
      inCutScene = true; 
      hud.alpha = 0;
    }
    if (_eatSeconds > 4.7 && _eatSeconds < 6) {
      FlxTween.tween(maisey, {x:1160, y:660}, 1, {onComplete: (_) -> maisey.faceLeft()});
    }
    if (_eatSeconds > 6 && !_charactersLeaving && _eatSeconds < 6.1) {
      inCutScenePrep(charactersTalk);
    }

    // End scene
    if (kevin.x == 2000) fadeOut();    
  }
}