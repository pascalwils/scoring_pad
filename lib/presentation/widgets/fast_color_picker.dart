import 'package:flutter/material.dart';
import 'package:scoring_pad/presentation/graphic_tools.dart';
import 'package:spring_button/spring_button.dart';

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

class FastColorPicker extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  static Color getDefaultColor() => colors[0];

  const FastColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: createColors(context, colors),
      ),
    );
  }

  List<Widget> createColors(BuildContext context, List<Color> colors) {
    const double size = 40.0;
    return [
      for (var c in colors)
        SpringButton(
          SpringButtonType.OnlyScale,
          Padding(
            padding: const EdgeInsets.all(size * 0.1),
            child: AnimatedContainer(
              width: size,
              height: size,
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  width: c == selectedColor ? 4 : 2,
                  color: Colors.white,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: size * 0.1,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: c == selectedColor
                  ? Icon(
                      Icons.check,
                      color: computeColorForText(selectedColor),
                    )
                  : null,
            ),
          ),
          onTap: () {
            onColorSelected.call(c);
          },
          useCache: false,
          scaleCoefficient: 0.9,
          duration: 1000,
        ),
    ];
  }
}
