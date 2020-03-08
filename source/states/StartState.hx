package states;

import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxG;

class StartState extends GameState {
	var _hlbLogo:FlxSprite;
	var _autisticaLogo:FlxSprite;

  var _seconds:Float = 0;

  public function new() {
    super();
  }

	override public function create() {
		super.create();
		FlxG.sound.music = null; // Make sure there's no music

		FlxG.sound.playMusic("assets/music/theme.ogg", 0.4, false);	
		FlxG.sound.music.persist = true;
			
		bgColor = FlxColor.WHITE;
		FlxG.cameras.fade(bgColor, 0.5, true); // Level fades in
		_hlbLogo = new FlxSprite(0, 0);
		_hlbLogo.loadGraphic("assets/images/logos/hl.png", false, 535, 239);
		centerImage(_hlbLogo);
		add(_hlbLogo);

		_autisticaLogo = new FlxSprite(0, 0);
		_autisticaLogo.loadGraphic("assets/images/logos/autistica.png", false, 658, 666);
		centerImage(_autisticaLogo);
		_autisticaLogo.alpha = 0;
		add(_autisticaLogo);		
	}  

  override public function update(elapsed:Float):Void{
    super.update(elapsed);
    _seconds += elapsed;
		if (_seconds > 2 && _seconds < 3) FlxTween.tween(_hlbLogo, {alpha: 0}, 0.5);
		if (_seconds > 3 && _seconds < 4) FlxTween.tween(_autisticaLogo, {alpha: 1}, 0.5);
		if (_seconds > 6 && _seconds < 7) FlxTween.tween(_autisticaLogo, {alpha: 0}, 0.5);
		if (_seconds > 8) FlxG.switchState(new TitleState());
  }
}