import 'package:flutter/material.dart';

/* ScoreCounter palette
const List<Color> colors = [
  Color(0xff74b9e6),
  Color(0xfff78db8),
  Color(0xffd2b992),
  Color(0xffff7b7b),
  Color(0xff71d398),
  Color(0xffffcc66),
  Color(0xfff4b162),
  Color(0xff838ea2),
  Color(0xff97d3c5),
  Color(0xffa5b5c8),
  Color(0xfff89493),
  Color(0xfff6da2f),
  Color(0xffdaed81),
  Color(0xffe0aa86),
  Color(0xfff8c973),
  Color(0xff89e5e2),
  Color(0xffc89e64),
  Color(0xff6ca0d1),
  Color(0xff91c2f2),
  Color(0xfff9a9ff),
  Color(0xffffa358),
  Color(0xfff4b162),
  Color(0xff29a9e3),
  Color(0xffa2a8ac),
  Color(0xffff7b7b),
];
*/

/* Color Brewer palettes
const List<Color> colors = [
  Color(0xffa6cee3),
  Color(0xff1f78b4),
  Color(0xffb2df8a),
  Color(0xff33a02c),
  Color(0xfffb9a99),
  Color(0xffe31a1c),
  Color(0xfffdbf6f),
  Color(0xffff7f00),
  Color(0xffcab2d6),
  Color(0xff6a3d9a),
  Color(0xffffff99),
  Color(0xffb15928),
];
const List<Color> colors = [
  Color(0xff8dd3c7),
  Color(0xffffffb3),
  Color(0xffbebada),
  Color(0xfffb8072),
  Color(0xff80b1d3),
  Color(0xfffdb462),
  Color(0xffb3de69),
  Color(0xfffccde5),
  Color(0xffd9d9d9),
  Color(0xffbc80bd),
  Color(0xffccebc5),
  Color(0xffffed6f),
];
*/

const List<Color> darkColors = [
  Color(0xff8a3ffc),
  Color(0xff33b1ff),
  Color(0xff007d79),
  Color(0xffff7eb6),
  Color(0xfffa4d56),
  Color(0xfffff1f1),
  Color(0xff6fdc8c),
  Color(0xff4589ff),
  Color(0xffd12771),
  Color(0xffd2a106),
  Color(0xff08bdba),
  Color(0xffbae6ff),
  Color(0xffba4e00),
  Color(0xffd4bbff),
];

const List<Color> lightColors = [
  Color(0xff6929c4),
  Color(0xff1192e8),
  Color(0xff005d5d),
  Color(0xff9f1853),
  Color(0xfffa4d56),
  Color(0xff570408),
  Color(0xff198038),
  Color(0xff002d9c),
  Color(0xffee538b),
  Color(0xffb28600),
  Color(0xff009d9a),
  Color(0xff012749),
  Color(0xff8a3800),
  Color(0xffa56eff),
];

List<Color> getColorPalette(Brightness brightness) {
  return brightness == Brightness.light ? lightColors : darkColors;
}
