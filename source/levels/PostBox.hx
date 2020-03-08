package levels;

import flixel.FlxObject;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import states.FullscreenText;

import states.LevelState;

import states.LevelState.SpeechData;

class PostBox extends LevelState {

  var _seconds:Float = 0;
  var _firstPass:Bool = false;
  var _charactersLeaving:Bool = false;

  var _postBox:FlxSprite;

  var _helpTextOne:FlxText;

  // Timings
  final _kevinStopsMoving:Float = 4;
  final _maiseyStopsMoving:Float = 4.2; 
  var _openHelpOne:Float = 0;
  var _closeHelpOne:Float = 0;  
  var _letterPosted:Float = 0;  
  
  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _openHelpOne = _maiseyStopsMoving + 1;
    _closeHelpOne = _openHelpOne + 3;     
  }

  override public function create() {
    super.create();

    // Add bg
    if (_firstPass) addBackground(); 

    addSpeech();

    // Help texts
    _helpTextOne = createHelpText(
      "Can you help <maisey>Maisy<maisey> post the letter?");
    add(_helpTextOne);
    
    // Envirionments
    _postBox = new FlxSprite(1518, 435);
    _postBox.loadGraphic("assets/images/environments/postBox.png", false, 130, 368);
    if (_firstPass) add(_postBox);    
    
    // Add characters (start offscreen)
    addKevin(-320, 622); 
    addMaisey(-140, 590);
    
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
    kevin.isListening = true;    
  }

  function charactersTalk(_) {
    final speechPos:Array<Int> = [860, 430];
    final sentences:Array<SpeechData> = [
      {
        x: speechPos[0], y: speechPos[1], text: "<maisey>Maisy<maisey>\nThat's one job done.", timing: 0
      },
      {
        x: speechPos[0], y: speechPos[1], text: "<maisey>Maisy<maisey>\nWhat an eventful morning.", timing: 3000
      },
      {
        x: speechPos[0], y: speechPos[1], text: "<maisey>Maisy<maisey>\nAre you ready to go home?", timing: 6000
      },
      {
        x: (speechPos[0] - 20), y: speechPos[1], text: "<kevin>Kevin<kevin>\nYes", timing: 9000
      },      
      {
        x: speechPos[0], y: speechPos[1], text: "", timing: 11000
      }              
    ];   

    if (!_charactersLeaving) {
      showSpeech(sentences, () -> outCutScenePrep(charactersLeaveScene)); 
    }
  }
  
  function charactersLeaveScene(_) {
    _charactersLeaving = true;
    speech.alpha = 0;
    maisey.faceLeft();
    kevin.isWalking = true;
    kevin.facing = FlxObject.LEFT;
    FlxTween.tween(kevin, {x: 0}, 8);
    FlxTween.tween(maisey, {x: 0}, 9);
  }  
  
  function showFirstText() {
    FlxG.switchState(new FullscreenText("Getting things done", "PostBox", [true]));
  }  

	function fadeOut() {
		FlxG.cameras.fade(FlxColor.WHITE, 0.5, false, changeState);
  }  
  
	function changeState() {
		FlxG.switchState(new PostBox());
  }    

  override public function update(elapsed:Float) {
    super.update(elapsed);
    _seconds += elapsed;

    if (_seconds > _kevinStopsMoving && _letterPosted == 0) {
      kevin.isListening = false;
      kevin.isIdle = true;
    } 
    
    if (_seconds > _openHelpOne && _seconds < _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5);
    if (_seconds > _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);   
    
    // Allow player interactivity
    if (_seconds > _openHelpOne && _letterPosted < 1) {
      hud.alpha = 1;
      inCutScene = false; 
      maisey.preventMovement = false;      
    }
    
    // What happens after letter posted
    if (_letterPosted > 0) _letterPosted += elapsed;    
    if (FlxG.mouse.overlaps(_postBox) && FlxG.mouse.justPressed && selectedItem == "envelope") {
      _letterPosted += elapsed; 
      hud.alpha = 0;
      hud.hideHud();      
      updateSelectedItem("");      
    }

    if (_letterPosted > 1 && _letterPosted < 2) {
      FlxTween.tween(maisey, {x:1187, y:630}, 1, {onComplete: (_) -> maisey.faceLeft()});
    }

    if (_letterPosted > 2 && _letterPosted < 2.1) {
      inCutScenePrep(charactersTalk);
      maisey.preventMovement = true;
    }

    if (_letterPosted > 7 && _letterPosted < 8) {
      kevin.isIdle = false;      
      kevin.isNodding = true;
    }
    // End scene
    if (_letterPosted > 12) fadeOut();      
  }
}