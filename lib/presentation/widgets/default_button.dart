import 'package:flutter/material.dart';

enum StyleEnum { elevated, filled, filledTonal, outlined, text }

class DefaultButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final EdgeInsets? padding;
  final Function()? onPressed;

  final StyleEnum styleEnum;

  const DefaultButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    required this.styleEnum,
    this.padding,
  });

  factory DefaultButton.elevated({
    Key? key,
    IconData? icon,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return DefaultButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      styleEnum: StyleEnum.elevated,
      padding: padding,
    );
  }

  factory DefaultButton.filled({
    Key? key,
    IconData? icon,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return DefaultButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      styleEnum: StyleEnum.filled,
      padding: padding,
    );
  }

  factory DefaultButton.filledTonal({
    Key? key,
    IconData? icon,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return DefaultButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      styleEnum: StyleEnum.filledTonal,
      padding: padding,
    );
  }

  factory DefaultButton.outlined({
    Key? key,
    IconData? icon,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return DefaultButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      styleEnum: StyleEnum.outlined,
      padding: padding,
    );
  }

  factory DefaultButton.text({
    Key? key,
    IconData? icon,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
  }) {
    return DefaultButton(
      key: key,
      label: label,
      onPressed: onPressed,
      icon: icon,
      styleEnum: StyleEnum.text,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (styleEnum) {
      case StyleEnum.elevated:
        final style = ElevatedButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return ElevatedButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return ElevatedButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case StyleEnum.filled:
        final style = FilledButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return FilledButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return FilledButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case StyleEnum.filledTonal:
        final style = FilledButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return FilledButton.tonalIcon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return FilledButton.tonal(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case StyleEnum.outlined:
        final style = OutlinedButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return OutlinedButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return OutlinedButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );

      case StyleEnum.text:
        final style = TextButton.styleFrom(
          elevation: 0,
          padding: padding,
        );
        if (icon != null) {
          return TextButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
        }
        return TextButton(
          style: style,
          onPressed: onPressed,
          child: Text(label),
        );
    }
  }
}
