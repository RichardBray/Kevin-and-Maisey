package components;

import flixel.system.FlxSound;
import flixel.FlxObject;
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
  var _headphonesBox:FlxSprite;

  var _strawberry:FlxSprite;
  var _strawberryBox:FlxSprite;

  var _envelope:FlxSprite;
  var _envelopeBox:FlxSprite;

  var _sndSwoosh:FlxSound;

  final pulloutSize:Array<Int> = [78, 74];

  public var itemComtainerShown: Bool = false;

  public function new(maisey:Maisey, updateSelectedItem:String->Void) {
    super();

    _player = maisey;
    _updateSelectedItem = updateSelectedItem;

    _sndSwoosh = FlxG.sound.load("assets/sounds/swoosh.ogg", 1);

    _pullOutTab = new FlxSprite(FlxG.width - pulloutSize[0], FlxG.height - pulloutSize[1]);
    _pullOutTab.loadGraphic("assets/images/items/toggle_open.png", false, pulloutSize[0], pulloutSize[1]);
    add(_pullOutTab);

    _itemContainer = new FlxSprite(0, FlxG.height);
    _itemContainer.loadGraphic("assets/images/items/toolkit.png", false, 1920, 215);
    add(_itemContainer);

    // Items
    _strawberry = new FlxSprite(0, 0);
    _strawberry.loadGraphic("assets/images/items/strawberry.png", false, 72, 116);
    
    _strawberryBox = new FlxSprite(140, 897);
    _strawberryBox.makeGraphic(150, 150, FlxColor.TRANSPARENT);
    _strawberryBox.alpha = 0;
    add(_strawberryBox);

    _headphones = new FlxSprite(0, 0);
    _headphones.loadGraphic("assets/images/items/headphones.png", false, 96, 97); 
     
    _headphonesBox = new FlxSprite(440, 897);
    _headphonesBox.makeGraphic(150, 150, FlxColor.TRANSPARENT);
    _headphonesBox.alpha = 0;
    add(_headphonesBox);

    _envelope = new FlxSprite(0, 0);
    _envelope.loadGraphic("assets/images/items/letter.png", false, 85, 58); 
    
    _envelopeBox = new FlxSprite(740, 897);
    _envelopeBox.makeGraphic(150, 150, FlxColor.TRANSPARENT);
    _envelopeBox.alpha = 0;
    add(_envelopeBox);
  }
  
  public function toggleItems(showItemContainer:Bool) {
    /** Pullput tab height change */
    final newItemHeight:Int = showItemContainer ? - 215 : 0;
    _sndSwoosh.play();
    FlxTween.tween(_itemContainer, {y: (FlxG.height + newItemHeight)}, 0.25);
    FlxTween.tween(
      _pullOutTab, 
      {y: ((FlxG.height - pulloutSize[1]) + newItemHeight)}, 
      0.25,
      {onComplete: (_) -> _toggleTweenEnded = true}
    );
  }

  public function hideHud() {
    toggleItems(false);
    itemComtainerShown = false;
  }

  function loadItem(box:FlxSprite, sprite:FlxSprite, name:String) {
    if (FlxG.mouse.overlaps(box) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      // itemComtainerShown = false;
      FlxG.mouse.load(sprite.pixels);
      _itemChosen = true;
      _updateSelectedItem(name);
    }
  }

  override public function update(elapsed:Float) {
    super.update(elapsed);
    if (FlxG.mouse.overlaps(_pullOutTab) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      itemComtainerShown = !itemComtainerShown;
      _toggleTweenEnded = false;
    }

    // This code is very bad, I know, it's a jam
    loadItem(_strawberryBox, _strawberry, "strawberry");
    loadItem(_headphonesBox, _headphones, "headphones");
    loadItem(_envelopeBox, _envelope, "envelope");
  
    // Reset all the item things
    if (_itemChosen && !FlxG.mouse.overlaps(_itemContainer) && FlxG.mouse.justPressed) {
      _player.preventMovement = true;
      FlxG.mouse.unload();
      _itemChosen = false;
    }

    // Show and hide itemsFix this up, maybe?
    if (itemComtainerShown) {
      _headphonesBox.alpha = 1;
      _strawberryBox.alpha = 1;
      _envelopeBox.alpha = 1;
    } else {
      _headphonesBox.alpha = 0;
      _strawberryBox.alpha = 0; 
      _envelopeBox.alpha = 0;     
    }

    if (FlxG.mouse.overlaps(_itemContainer) && FlxG.mouse.justPressed) _player.preventMovement = true;

    if (!_toggleTweenEnded) toggleItems(itemComtainerShown);
  }
}