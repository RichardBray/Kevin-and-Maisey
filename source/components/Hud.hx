package components;

import utils.Constants;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;

import characters.Maisey;


class Hud extends FlxSpriteGroup {
  var _pullOutTab: FlxSprite;
  var _itemContainer: FlxSprite;
  var _itemChosen:Bool = false;
  var _toggleTweenEnded:Bool = true; // To prevent items from tweening at different speeds

  var _player:Maisey; // Prevent movement when clicking in items container
  var _updateSelectedItem:String->Void;

  var _headphones:FlxSprite;
  var _strawberry:FlxSprite;
  var _envelope:FlxSprite;

  public var itemComtainerShown: Bool = false;

  public function new(maisey:Maisey, updateSelectedItem:String->Void) {
    super();

    _player = maisey;
    _updateSelectedItem = updateSelectedItem;

    _pullOutTab = new FlxSprite(FlxG.width - 60, FlxG.height - 60);
    _pullOutTab.makeGraphic(60, 60, FlxColor.BLACK);
    add(_pullOutTab);

    _itemContainer = new FlxSprite(0, FlxG.height);
    _itemContainer.makeGraphic(FlxG.width, 200, Constants.itemContainerGreen);
    add(_itemContainer);

    // Items
    _headphones = new FlxSprite(100, 910);
    _headphones.makeGraphic(60, 60, FlxColor.WHITE);
    _headphones.alpha = 0;
    add(_headphones);

    _strawberry = new FlxSprite(180, 910);
    _strawberry.loadGraphic("assets/images/items/strawberry.png", false, 72, 116);
    _strawberry.alpha = 0;
    add(_strawberry);    
  }
  
  public function toggleItems(showItemContainer:Bool) {
    /** Pullput tab height change */
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

    // This code is very bad, I know, it's a jam
    if (FlxG.mouse.overlaps(_strawberry) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      // itemComtainerShown = false;
      FlxG.mouse.load(_strawberry.pixels);
      _itemChosen = true;
      _updateSelectedItem("strawberry");
    }
  
    // Reset all the item things
    if (_itemChosen && !FlxG.mouse.overlaps(_itemContainer) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      FlxG.mouse.unload();
      _itemChosen = false;
    }

    // Show and hide itemsFix this up, maybe?
    if (itemComtainerShown) {
      _headphones.alpha = 1;
      _strawberry.alpha = 1;
    } else {
      _headphones.alpha = 0;
      _strawberry.alpha = 0;      
    }

    if (FlxG.mouse.overlaps(_itemContainer) && FlxG.mouse.justPressed) _player.preventMovement = true;

    if (!_toggleTweenEnded) toggleItems(itemComtainerShown);
  }
}