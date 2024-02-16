import 'package:flutter/material.dart';

class Expandable extends StatefulWidget {
  /// The widget that is placed at the non-collapsing part of the expandable.
  final Widget firstChild;

  /// The widget that size transition affects.
  final Widget secondChild;

  /// Animation starts BEFORE and ends AFTER this function.
  ///
  /// Notice that this function can not be triggered more than once while animating Expandable.
  final Function? onPressed;

  /// Background color of the expandable.
  final Color backgroundColor;

  /// Duration for expand & rotate animations.
  final Duration animationDuration;

  /// Whether expandable will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  final Color arrowColor;

  final Function? onLongPress;

  /// Custom animation for size & rotation animations.
  ///
  /// Notice that there is no separate support for size & rotation animations.
  final Animation<double>? animation;

  /// Controller for [animation].
  ///
  /// Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  final void Function(bool)? onHover;

  final List<BoxShadow>? boxShadow;

  /// [BorderRadius] of [Expandable].
  ///
  /// shape property removed from the version 1.0.2 (no need) and [borderRadius] added.
  final BorderRadius? borderRadius;

  /// Expandable widget for general use.
  ///
  /// [backgroundColor], [animationDuration], [centralizeFirstChild] & [clickable] arguments must not be null.
  const Expandable({
    super.key,
    required this.firstChild,
    required this.secondChild,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.arrowColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 400),
    this.initiallyExpanded,
    this.borderRadius,
    this.onLongPress,
    this.animation,
    this.animationController,
    this.onHover,
    this.boxShadow,
  });

  @override
  ExpandableState createState() => ExpandableState();
}

class ExpandableState extends State<Expandable> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  final sizeTween = Tween<double>(begin: 0.0, end: 1.0);

  bool initiallyExpanded = false;

  @override
  void initState() {
    super.initState();
    initiallyExpanded = widget.initiallyExpanded ?? false;
    controller = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: widget.animationDuration,
        );

    animation = widget.animation ??
        sizeTween.animate(
          CurvedAnimation(
            parent: controller,
            curve: Curves.fastOutSlowIn,
          ),
        );
  }

  @override
  void dispose() {
    if (widget.animationController != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded) {
      _toggleExpand();
    }
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: widget.boxShadow,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
      ),
      child: _buildVerticalExpandable(),
    );
  }

  void _toggleExpand() {
    if (initiallyExpanded) {
      initiallyExpanded = false;
    }
    switch (animation.status) {
      case AnimationStatus.completed:
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  Future<void> _onPressed() async {
    if (widget.onPressed != null && !controller.isAnimating) {
      await widget.onPressed!();
    }
    _toggleExpand();
  }

  Future<void> _onLongPress() async {
    if (widget.onLongPress != null && !controller.isAnimating) {
      await widget.onLongPress!();
    }
  }

  void _onHover(bool isHovered) {
    if (widget.onHover != null) {
      widget.onHover!(isHovered);
    }

    if (isHovered) {
      _toggleExpand();
    } else if (!isHovered) {
      if (!initiallyExpanded) {
        controller.reverse();
      }
    }
  }

  RotationTransition _buildRotation() {
    return RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(animation),
      child: Icon(
        Icons.keyboard_arrow_up_rounded,
        color: widget.arrowColor,
        size: 25.0,
      ),
    );
  }

  Column _buildVerticalExpandable() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.onHover != null ? _onHover : null,
          onTap: _onPressed,
          onLongPress: _onLongPress,
          child: _buildBodyWithArrow(),
        ),
        _buildInkWellContainer(),
      ],
    );
  }

  Widget _buildBodyWithArrow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.ltr,
      children: [
        widget.firstChild,
        _buildRotation(),
      ],
    );
  }

  InkWell _buildInkWellContainer() {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHover: widget.onHover != null ? _onHover : null,
      onTap: null,
      onLongPress: null,
      child: _buildSecondChild(),
    );
  }

  SizeTransition _buildSecondChild() {
    return SizeTransition(
      axisAlignment: 1,
      axis: Axis.vertical,
      sizeFactor: animation,
      child: widget.secondChild,
    );
  }
}
