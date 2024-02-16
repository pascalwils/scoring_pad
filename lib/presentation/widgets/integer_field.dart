import 'package:flutter/material.dart';

class IntegerField extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;
  final String text;
  final TextStyle style;
  final Color buttonBackground;

  const IntegerField({
    super.key,
    required this.text,
    required this.style,
    required this.buttonBackground,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 100,
    this.step = 1,
  });

  @override
  IntegerFieldState createState() => IntegerFieldState();
}

class IntegerFieldState extends State<IntegerField> {
  int _value = 0;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text('$_value', style: widget.style.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(widget.text, style: widget.style),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              IconButton.filled(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(widget.buttonBackground)),
                icon: const Icon(Icons.remove),
                onPressed: _value - widget.step >= widget.minValue
                    ? () => setState(() {
                          _value -= widget.step;
                        })
                    : null,
              ),
              const SizedBox(width: 4),
              IconButton.filled(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(widget.buttonBackground)),
                icon: const Icon(Icons.add),
                onPressed: _value + widget.step <= widget.maxValue
                    ? () => setState(() {
                          _value += widget.step;
                        })
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
