import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:pref/pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrefColor extends StatelessWidget {
  static const int defaultColor = 0xffffffff;
  static const double circleDiameter = 32;

  const PrefColor({
    super.key,
    this.title,
    required this.pref,
    this.subtitle,
    this.onChange,
    this.disabled,
  });

  final Widget? title;

  final Widget? subtitle;

  final String pref;

  final bool? disabled;

  final ValueChanged<Color>? onChange;

  @override
  Widget build(BuildContext context) {
    return PrefCustom<int>(
      pref: pref,
      title: title,
      subtitle: subtitle,
      onChange: onChange == null ? null : (v) => onChange!(Color(v ?? defaultColor)),
      disabled: disabled,
      onTap: _tap,
      builder: (c, v) => Container(
        width: circleDiameter,
        height: circleDiameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(v ?? defaultColor),
        ),
      ),
    );
  }

  Future<int?> _tap(BuildContext context, int? value) async {
    var newValue = value ?? defaultColor;
    AppLocalizations tr = AppLocalizations.of(context);

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: MaterialColorPicker(
          allowShades: false,
          selectedColor: Color(newValue),
          onMainColorChange: (color) {
            newValue = color?.value ?? defaultColor;
          },
        ),
        actions: [
          ElevatedButton(
            child: Text(tr.ok),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    return result == true ? newValue : value;
  }
}
