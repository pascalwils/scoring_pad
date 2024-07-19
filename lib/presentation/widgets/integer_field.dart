import 'package:flutter/material.dart';

class IntegerField extends StatelessWidget {
  final int value;
  final int? oldValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String text;
  final TextStyle style;
  final TextStyle? oldValueStyle;
  final Color buttonBackground;
  final void Function(int) onChange;

  const IntegerField({
    super.key,
    required this.text,
    required this.style,
    required this.buttonBackground,
    this.value = 0,
    this.oldValue,
    this.oldValueStyle,
    this.minValue = 0,
    this.maxValue = 100,
    this.step = 1,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: _buildRow(),
      ),
    );
  }

  List<Widget> _buildRow() {
    final result = List<Widget>.empty(growable: true);
    if (oldValue != null && value != oldValue) {
      final textStyle = oldValueStyle ?? style;
      result.add(Text('$oldValue', style: textStyle.copyWith(fontWeight: FontWeight.bold)));
      result.add(const SizedBox(width: 8));
    }
    result.add(Text('$value', style: style.copyWith(fontWeight: FontWeight.bold)));
    result.add(const SizedBox(width: 12));
    result.add(Expanded(child: Text(text, style: style)));
    result.add(const SizedBox(width: 12));
    result.add(Row(children: _buildButtons()));
    return result;
  }

  List<Widget> _buildButtons() {
    final result = List<Widget>.empty(growable: true);
    result.add(
      SizedBox(
        width: 36,
        height: 36,
        child: IconButton.filled(
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(buttonBackground)),
          icon: const Icon(Icons.remove, size: 20),
          onPressed: value - step >= minValue ? () => onChange(value - step) : null,
        ),
      ),
    );
    result.add(const SizedBox(width: 4));
    result.add(
      SizedBox(
        width: 36,
        height: 36,
        child: IconButton.filled(
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(buttonBackground)),
          icon: const Icon(Icons.add, size: 20),
          onPressed: value + step <= maxValue ? () => onChange(value + step) : null,
        ),
      ),
    );
    return result;
  }
}
