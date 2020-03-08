package states;

import flixel.ui.FlxButton;
import utils.Constants;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.FlxG;

class PauseState extends FlxSubState {
  var _bgOverlay:FlxSprite;
  var _pauseTitle:FlxText;

  var _boBackBtn:FlxButton;

  public function new() {
    super();
    // Reset mouse
    FlxG.mouse.unload();

		haxe.Timer.delay(() -> {
			if (FlxG.sound.music != null) FlxG.sound.music.pause();
			FlxG.sound.pause();
		}, 100);        
  }

  override public function create() {
    super.create();

    _bgOverlay = new FlxSprite(0, 0);
    _bgOverlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    add(_bgOverlay);

    _pauseTitle = new FlxText(0, 450, 0, "Game Paused");
    _pauseTitle.setFormat(Constants.rokkittRegular, Constants.hroFont, FlxColor.BLACK, CENTER);
    _pauseTitle.screenCenter(X);
    add(_pauseTitle);

    _boBackBtn = new FlxButton(0, _pauseTitle.y + 200, "Continue", closePauseMenu);
    _boBackBtn.screenCenter(X);
    _boBackBtn.width = 200;
    _boBackBtn.health = 200;
    _boBackBtn.label.setFormat(Constants.rokkittRegular, Constants.medFont, FlxColor.BLACK);
    // add(_boBackBtn);
  }

  function closePauseMenu() {
    if (FlxG.sound.music != null) FlxG.sound.music.play();
		FlxG.sound.resume();
    close(); 
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE) closePauseMenu();  
  }
}