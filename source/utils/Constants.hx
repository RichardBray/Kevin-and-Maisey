package utils;

import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.text.FlxText.FlxTextFormat;
import flixel.util.FlxColor;

import states.LevelState;
import levels.Intro;

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
  public static final kevinGreen:FlxColor = 0xff72cee6; // Dark background green
  public static final maiseyRed:FlxColor = 0xffe91e63; // Dark background green

	// Levels
	public static final levelNames:Map<String, Class<LevelState>> = [
		"Intro" => Intro, 
		"Park" => Intro,
		"Postbox" => Intro
  ];  
  
  // Text formatting
  public static final fontFormatting:Array<FlxTextFormatMarkerPair> = [
    new FlxTextFormatMarkerPair(new FlxTextFormat(kevinGreen, true, false), "<kevin>"),
    new FlxTextFormatMarkerPair(new FlxTextFormat(maiseyRed, true, false), "<maisey>"),
    new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.BLACK, true, false), "<strong>")
  ];
}