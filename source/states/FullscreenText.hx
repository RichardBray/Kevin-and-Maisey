package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;

import utils.Constants;


class FullscreenText extends GameState {
  var _mainText: FlxText;
  var _continueText: FlxText;


  var _backgroundSprite:FlxSprite;
  var _compText:String = "";
  var _compTextWidth:Int = 0;
  var _levelToSwitch:Class<states.LevelState>;
  var _levelArgs:Array<Dynamic> = [];

  public var screenSeen:Bool = false;

  /**
   * Display full screen text to explain game story. 
   *
   * @param compText Text for needed for this component. Should be just one sentence.
   * @param levelName Level to change state to when text is clicked.
   * @param compTextWidth Size of FlxText component if it's too lard. Defaulted to 500
   */
  public function new(compText:String, levelName:String, levelArgs:Array<Dynamic>, compTextWidth:Int = 500) {
    super();

    _compText = compText;
    _compTextWidth = compTextWidth;
    _levelToSwitch = Constants.levelNames[levelName];   
    _levelArgs =  levelArgs;
  }

  override public function create() {
    super.create();
  
    // Background sprite
    _backgroundSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    add(_backgroundSprite);


    
    // Main text
    _mainText = new FlxText(0, 0, _compTextWidth, _compText);
    _mainText.setFormat(Constants.rokkittRegular, Constants.lrgFont, FlxColor.BLACK, CENTER);
    _mainText.screenCenter(XY);
    _mainText.applyMarkup(_compText, Constants.fontFormatting);
    _mainText.alpha = 0;
    add(_mainText);

    // Sub text
    _continueText = new FlxText(0, FlxG.height - 100, 0, "Click to Continue");
    _continueText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _continueText.screenCenter(X);
    _continueText.alpha = 0;
    add(_continueText);    
  }

  public function show() {
    FlxTween.tween(_mainText, {alpha: 1}, 0.25, {ease: FlxEase.quadIn});
    haxe.Timer.delay(() -> {
      FlxTween.tween(_continueText, {alpha: 1}, 0.25, {ease: FlxEase.quadIn});
    }, 1000);	
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);  
    
    show();
    if (FlxG.mouse.justPressed) FlxG.switchState(Type.createInstance(_levelToSwitch, _levelArgs));
  }
}