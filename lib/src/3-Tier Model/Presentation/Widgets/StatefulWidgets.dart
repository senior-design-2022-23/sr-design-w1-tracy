import 'dart:math';

import 'package:flutter/material.dart';
import 'package:migraine_aid/src/3-Tier%20Model/Presentation/Widgets/BodyWidgets.dart';

class RepeatingGradientButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  final String emoji;
  final Color color;
  final bool shouldShake;
  RepeatingGradientButton(
      {required this.onPressed,
      required this.text,
      this.emoji = "",
      this.color = Colors.blue,
      this.shouldShake = false});

  @override
  _RepeatingGradientButtonState createState() =>
      _RepeatingGradientButtonState();
}

class _RepeatingGradientButtonState extends State<RepeatingGradientButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 6), () {
          if (mounted) {
            _controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 6), () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    });

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Material(
              type: MaterialType.card,
              elevation: 5,
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white10,
                borderRadius: BorderRadius.circular(15.0),
                onTap: () {
                  widget.onPressed();
                }, // handled by GestureDetector
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WidgetConstructor.createText(widget.text,
                          align: TextAlign.center, fontWeight: FontWeight.bold),
                      widget.shouldShake
                          ? Transform.rotate(
                              angle: sin(15 * _controller.value * 2 * pi) *
                                  0.2 *
                                  (_controller.value - 1), // shake logic
                              child: Text(
                                widget.emoji,
                                style: const TextStyle(
                                  fontSize: 60,
                                ),
                              ),
                            )
                          : Text(
                              widget.emoji,
                              style: const TextStyle(
                                fontSize: 60,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ClickableTooltip extends StatefulWidget {
  final Widget child;
  final String message;

  ClickableTooltip({required this.child, required this.message});

  @override
  _ClickableTooltipState createState() => _ClickableTooltipState();
}

class _ClickableTooltipState extends State<ClickableTooltip> {
  final GlobalKey _tooltipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final dynamic tooltip = _tooltipKey.currentState;
        tooltip?.ensureTooltipVisible();
      },
      child: Tooltip(
        key: _tooltipKey,
        message: widget.message,
        child: widget.child,
      ),
    );
  }
}
