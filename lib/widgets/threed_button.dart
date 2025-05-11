import 'dart:async';
import 'package:flutter/material.dart';
import 'package:venhanh/theme/pallete.dart';

class ThreeDButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width;
  final double height;
  final Color color;

  const ThreeDButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width = 100,
    this.height = 100,
    this.color = Pallete.primaryColor,
  });

  @override
  ThreeDButtonState createState() => ThreeDButtonState();
}

class ThreeDButtonState extends State<ThreeDButton> {
  bool _isPressed = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) async {
        widget.onPressed();
        _timer?.cancel();
        _timer = await Future.delayed(const Duration(milliseconds: 70), () {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
          return null;
        });
      },
      onTapCancel: () {
        _timer?.cancel();
        setState(() {
          _isPressed = false;
        });
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              bottom: 0,
              left: 5,
              right: 0,
              child: Container(
                height: widget.height - 5,
                decoration: BoxDecoration(
                  color: Pallete.blackColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              bottom: _isPressed ? 0 : 5,
              right: _isPressed ? 0 : 5,
              child: Container(
                height: widget.height - 5,
                width: widget.width - 5,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Pallete.blackColor.withAlpha(_isPressed ? 20 : 50),
                    width: 1,
                  ),
                ),
                child: Center(child: widget.child),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
