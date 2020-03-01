package components;

import characters.Maisey;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;

import utils.Constants;


class FullscreenText extends FlxSpriteGroup {
  var _mainText: FlxText;
  var _continueText: FlxText;
  var _kevinTextColor:FlxTextFormat;
  var _maiseyTextColor:FlxTextFormat;
  var _boldFont:FlxTextFormat;

  var _backgroundSprite:FlxSprite;
  var _player:Maisey;

  public var screenSeen:Bool = false;

  /**
   * Display full screen text to explain game story. 
   *
   * @param compText Text for needed for this component. Should be just one sentence.
   * @param player Needed to prevent player movement when screen is shown.
   * @param compTextWidth Size of FlxText component if it's too lard. Defaulted to 500
   */
  public function new(compText:String, player:Maisey, compTextWidth:Int = 500) {
    super();

    _player = player;

    // Background sprite
    _backgroundSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    _backgroundSprite.alpha = 0;
    add(_backgroundSprite);

    // Formatting for main text
    _kevinTextColor = new FlxTextFormat(Constants.kevinGreen, true, false);
    _maiseyTextColor = new FlxTextFormat(Constants.maiseyRed, true, false);
    _boldFont = new FlxTextFormat(FlxColor.BLACK, true, false);
    
    // Main text
    _mainText = new FlxText(0, 0, compTextWidth, compText);
    _mainText.setFormat(Constants.rokkittRegular, Constants.lrgFont, FlxColor.BLACK, CENTER);
    _mainText.screenCenter(XY);
    _mainText.applyMarkup(compText, [
      new FlxTextFormatMarkerPair(_kevinTextColor, "<kevin>"),
      new FlxTextFormatMarkerPair(_maiseyTextColor, "<maisey>"),
      new FlxTextFormatMarkerPair(_boldFont, "<strong>")
    ]);
    _mainText.alpha = 0;
    add(_mainText);

    // Sub text
    _continueText = new FlxText(0, _mainText.y + 200, 0, "Click to Continue");
    _continueText.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK, CENTER);
    _continueText.screenCenter(X);
    _continueText.alpha = 0;
    add(_continueText);
  }

  public function show() {
    _player.preventMovement = true;
    _backgroundSprite.alpha = 1;
    FlxTween.tween(_mainText, {alpha: 1}, 0.25, {ease: FlxEase.quadIn});
    haxe.Timer.delay(() -> {
      FlxTween.tween(_continueText, {alpha: 1}, 0.25, {ease: FlxEase.quadIn});
    }, 1000);	
  }

  public function hide() {
    _player.preventMovement = false;
    _backgroundSprite.alpha = 0;
    _mainText.alpha = 0;
    _continueText.alpha = 0;
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);  
   
    // Hide component on click 
    if (FlxG.mouse.justPressed) screenSeen = true;
  }
}