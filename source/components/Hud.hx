package components;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;

import characters.Maisey;


class Hud extends FlxSpriteGroup {
  var _pullOutTab: FlxSprite;
  var _itemContainer: FlxSprite;
  var _toggleTweenEnded:Bool = true; // To prevent items from tweening at different speeds
  var _player:Maisey;
  var _headphones:FlxSprite;

  public var itemComtainerShown: Bool = false;

  public function new(maisey:Maisey) {
    super();

    _player = maisey;

    _pullOutTab = new FlxSprite(FlxG.width - 60, FlxG.height - 60);
    _pullOutTab.makeGraphic(60, 60, FlxColor.BLACK);
    add(_pullOutTab);

    _itemContainer = new FlxSprite(0, FlxG.height);
    _itemContainer.makeGraphic(FlxG.width, 200, FlxColor.BLACK);
    add(_itemContainer);

    // Items
    _headphones = new FlxSprite(0, 0);
    _headphones.makeGraphic(60, 60, FlxColor.WHITE);
    _headphones.alpha = 0;
    add(_headphones);
  }
  
  public function toggleItems(showItemContainer:Bool) {
    final newItemHeight:Int = showItemContainer ? - 200 : 0;
    
    FlxTween.tween(_itemContainer, {y: (FlxG.height + newItemHeight)}, 0.25);
    FlxTween.tween(
      _pullOutTab, 
      {y: ((FlxG.height - 60) + newItemHeight)}, 
      0.25,
      {onComplete: (_) -> _toggleTweenEnded = true}
    );
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (FlxG.mouse.overlaps(_pullOutTab) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      itemComtainerShown = !itemComtainerShown;
      _toggleTweenEnded = false;
    }

    if (FlxG.mouse.overlaps(_itemContainer) && FlxG.mouse.justPressed) _player.preventMovement = true;

    if (!_toggleTweenEnded) toggleItems(itemComtainerShown);
  }
}