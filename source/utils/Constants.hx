package utils;

import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.text.FlxText.FlxTextFormat;
import flixel.util.FlxColor;

import states.LevelState;
import levels.Intro;
import levels.Park;

class Constants {
  // General
  public static final rokkittRegular:String = "assets/fonts/Rokkitt-Regular.ttf";
  public static final rokkittBold:String = "assets/fonts/Rokkitt-Bold.ttf";

  // Font sizes
	public static final smlFont:Int = 24;
	public static final medFont:Int = 36;
  public static final lrgFont:Int = 48; 
  public static final hroFont:Int = 60; 
  
  // Colours
  public static final kevinGreen:FlxColor = 0xff999908;
  public static final maiseyRed:FlxColor = 0xfffe4552; 
  public static final floorBlue:FlxColor = 0xffb0caca;
  public static final itemContainerGreen:FlxColor = 0xff206933;

	// Levels
	public static final levelNames:Map<String, Class<LevelState>> = [
		"Intro" => Intro, 
    "Park" => Park,
    "BusStop" => Intro,
		"Postbox" => Intro
  ];  
  
  // Text formatting
  public static final fontFormatting:Array<FlxTextFormatMarkerPair> = [
    new FlxTextFormatMarkerPair(new FlxTextFormat(kevinGreen, true, false), "<kevin>"),
    new FlxTextFormatMarkerPair(new FlxTextFormat(maiseyRed, true, false), "<maisey>"),
    new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.BLACK, true, false), "<strong>")
  ];
}