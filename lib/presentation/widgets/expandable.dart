import 'package:flutter/material.dart';

/// • enum to decide the clickable area of Expandable widgets.
enum Clickable {
  none,
  everywhere,
  firstChildOnly,
}

/// • enum for arrowLocation (which is a property of ExpandableText).
enum ArrowLocation {
  top,
  right,
  bottom,
  left,
}

class Expandable extends StatefulWidget {
  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget firstChild;

  /// • The widget that size transition affects.
  final Widget secondChild;

  /// •
  final Widget? subChild;

  /// • Animation starts BEFORE and ends AFTER this function.
  ///
  /// • Notice that this function can not be triggered more than once while animating Expandable.
  final Function? onPressed;

  /// • Background color of the expandable.
  final Color backgroundColor;

  /// • Duration for expand & rotate animations.
  final Duration animationDuration;

  /// • Background image of the expandable.
  final DecorationImage? backgroundImage;

  /// • Whether [arrowWidget] will be shown or not.
  final bool? showArrowWidget;

  /// • Whether expandable will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Custom widget that changes its direction with respect to expand animation.
  final Widget? arrowWidget;

  /// • Place of the arrow widget.
  final ArrowLocation? arrowLocation;

  final Color arrowColor;

  final Function? onLongPress;

  /// • Custom animation for size & rotation animations.
  ///
  /// • Notice that there is no separate support for size & rotation animations.
  final Animation<double>? animation;

  /// • Controller for [animation].
  ///
  /// • Useful when one want to interact with the expandable with an external button etc.
  final AnimationController? animationController;

  final void Function(bool)? onHover;

  final List<BoxShadow>? boxShadow;

  /// • [BorderRadius] of [Expandable].
  ///
  /// • shape property removed from the version 1.0.2 (no need) and [borderRadius] added.
  final BorderRadius? borderRadius;

  /// • Decide click behaviour of the Expandable.
  ///
  /// • See [Clickable] for possible options.
  final Clickable clickable;

  /// • Expandable widget for general use.
  ///
  /// • [backgroundColor], [animationDuration], [centralizeFirstChild] & [clickable] arguments must not be null.
  const Expandable({
    super.key,
    required this.firstChild,
    required this.secondChild,
    this.subChild,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.arrowColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 400),
    this.backgroundImage,
    this.showArrowWidget,
    this.initiallyExpanded,
    this.arrowWidget,
    this.arrowLocation = ArrowLocation.right,
    this.borderRadius,
    this.clickable = Clickable.firstChildOnly,
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

  void toggleExpand() {
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

  Future<void> onPressed() async {
    if (widget.onPressed != null && !controller.isAnimating) {
      await widget.onPressed!();
    }
    toggleExpand();
  }

  Future<void> onLongPress() async {
    if (widget.onLongPress != null && !controller.isAnimating) {
      await widget.onLongPress!();
    }
  }

  void onHover(bool isHovered) {
    if (widget.onHover != null) {
      widget.onHover!(isHovered);
    }

    if (isHovered) {
      toggleExpand();
    } else if (!isHovered) {
      if (!initiallyExpanded) {
        controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded) toggleExpand();
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        image: widget.backgroundImage,
        boxShadow: widget.boxShadow,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(5.0),
      ),
      child: buildVerticalExpandable(),
    );
  }

  RotationTransition buildRotation() {
    return RotationTransition(
      turns: Tween(begin: 0.5, end: 0.0).animate(animation),
      child: widget.arrowWidget ??
          Icon(
            Icons.keyboard_arrow_up_rounded,
            color: widget.arrowColor,
            size: 25.0,
          ),
    );
  }

  Column buildVerticalExpandable() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHover: widget.onHover != null ? onHover : null,
          onTap: widget.clickable != Clickable.none ? onPressed : null,
          onLongPress: widget.clickable != Clickable.none ? onLongPress : null,
          child: widget.showArrowWidget ?? true == true
              ? buildBodyWithArrow()
              : widget.subChild != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [widget.firstChild],
                        ),
                        widget.subChild!,
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [widget.firstChild],
                    ),
        ),
        buildInkWellContainer(buildSecondChild()),
      ],
    );
  }

  Widget buildBodyWithArrow() {
    return widget.subChild != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.firstChild,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                textDirection: widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
                children: [
                  widget.subChild!,
                  buildRotation(),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textDirection: widget.arrowLocation == ArrowLocation.right ? TextDirection.ltr : TextDirection.rtl,
            children: [
              widget.firstChild,
              buildRotation(),
            ],
          );
  }

  SizeTransition buildSecondChild() {
    return SizeTransition(
      axisAlignment: 1,
      axis: Axis.vertical,
      sizeFactor: animation,
      child: widget.secondChild,
    );
  }

  InkWell buildInkWellContainer(Widget child) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onHover: widget.onHover != null ? onHover : null,
      onTap: widget.clickable == Clickable.everywhere ? onPressed : null,
      onLongPress: widget.clickable == Clickable.everywhere ? onLongPress : null,
      child: child,
    );
  }
}
