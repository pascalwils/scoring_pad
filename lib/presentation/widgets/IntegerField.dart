import 'package:flutter/material.dart';

class IntegerField extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final int step;

  const IntegerField({
    super.key,
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

  void _increment() {
    if (_value + widget.step <= widget.maxValue) {
      setState(() {
        _value += widget.step;
      });
    }
  }

  void _decrement() {
    if (_value - widget.step >= widget.minValue) {
      setState(() {
        _value -= widget.step;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          InkWell(
              onTap: () {
                _decrement();
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 24,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: SizedBox(
              width: 40,
              child: Text(
                '$_value',
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          InkWell(
              onTap: () {
                _increment();
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 24,
              )),
        ],
      ),
    );
  }
}
