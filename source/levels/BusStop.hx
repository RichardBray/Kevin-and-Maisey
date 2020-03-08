package levels;

import flixel.text.FlxText;
import characters.Rabbit3;
import characters.Rabbit2;
import characters.Rabbit1;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import states.FullscreenText;

import states.LevelState;

class BusStop extends LevelState {

  var _seconds:Float = 0;
  var _listenSeconds:Float = 0;
  var _firstPass:Bool = false;

  var _busPost:FlxSprite;
  var _rabbit1:Rabbit1;
  var _rabbit2:Rabbit2;
  var _rabbit3:Rabbit3;

  var _helpTextOne:FlxText;  

  // Timings
  final _kevinStopsMoving:Float = 2.5;
  final _maiseyStopsMoving:Float = 2.7; 
  var _kevinInShell:Float = 0;
  var _openHelpOne:Float = 0;
  var _closeHelpOne:Float = 0;   
  
  public function new(firstPass:Bool = false) {
    super();
    _firstPass = firstPass;
    _openHelpOne = _maiseyStopsMoving + 2;
    _closeHelpOne = _openHelpOne + 4;    
    _kevinInShell = _kevinStopsMoving + 1;
  }

  override public function create() {
    super.create();

    // Add bg
    if (_firstPass) addBackground(); 
    
    // Help texts
    _helpTextOne = createHelpText(
      "What can you do to help <kevin>Kevin<kevin> get out of his shell?");
    add(_helpTextOne);
      
    // Envirionments
    _busPost = new FlxSprite(1518, 445);
    _busPost.loadGraphic("assets/images/environments/busStop.png", false, 102, 375);
    add(_busPost);

    // Add characters (start offscreen)
    _rabbit1 = new Rabbit1(1000, 717);
    add(_rabbit1);

    _rabbit2 = new Rabbit2((1000 + (_rabbit1.width/2)), 465);
    add(_rabbit2);

    _rabbit3 = new Rabbit3((1000 + (_rabbit2.width + 30)), 482);
    add(_rabbit3);         
  
    addKevin(-320, 622); 
    addMaisey(-140, 590);
    
    // Add hud
    addHud();
    hud.alpha = 0;
    
    // Fullscreen texts
    if (!_firstPass) showFirstText();  
    
    // Players move on scene start
    FlxTween.tween(maisey, {x: 730}, _maiseyStopsMoving);
    FlxTween.tween(kevin, {x: 380}, _kevinStopsMoving);  
    
    // Prevent maisy from moving on click
    inCutScene = true;
    maisey.preventMovement = true;   
    maisey.isFlying = true;
    kevin.isWalking = true;    
  }

  function showFirstText() {
    FlxG.switchState(new FullscreenText("Bus stop boogie", "BusStop", [true]));
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

    if (_seconds > _kevinStopsMoving && _seconds < _kevinInShell) {
      kevin.isWalking = false;
      kevin.isInShell = true;
    }   
    if (_seconds > (_maiseyStopsMoving + 1) && _seconds < _openHelpOne) maisey.faceLeft();
    if (_seconds > _kevinInShell && _listenSeconds == 0) { // and here
      kevin.isInShell = false;
      kevin.isInShellIdle = true;
    } 
    if (_seconds > _openHelpOne && _seconds < _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 1}, 0.5);
    if (_seconds > _closeHelpOne) FlxTween.tween(_helpTextOne, {alpha: 0}, 0.5);
  
    if (_seconds > (_kevinInShell + 1) && _listenSeconds < 1) {
      hud.alpha = 1;
      inCutScene = false; 
      maisey.preventMovement = false;      
    }
    // Kevin wears headphones
    if (_listenSeconds > 0) _listenSeconds += elapsed; // Start eat timer
    if (FlxG.mouse.overlaps(kevin) && FlxG.mouse.justPressed && selectedItem == "headphones") {
      kevin.isInShellIdle = false;       
      kevin.isListening = true; 
      _listenSeconds += elapsed;
      hud.alpha = 0;
      hud.hideHud();
      FlxTween.tween(kevin, {x: 2000}, 6);
      updateSelectedItem("");
    }   
    if (_listenSeconds > 2) {
      FlxTween.tween(maisey, {x: 2000}, 4);
      maisey.faceRight();
    }
    
    // End scene
    if (kevin.x == 2000) fadeOut();    
  }
}