import 'package:flutter/material.dart';

class AnimHomne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          CircleTransitionPainter(Colors.teal, Colors.red, Colors.green, 0),
      child: Container(),
    );
  }
}

class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter(
    Color backgroundColor,
    Color currentCircleColor,
    Color nextCircleColor,
    double transitionPercent,
  )   : backgroundpaint = Paint()..color = backgroundColor,
        currentCirclepaint = Paint()..color = currentCircleColor,
        nextCirclePaint = Paint()..color = nextCircleColor;
  final Paint backgroundpaint;
  final Paint currentCirclepaint;
  final Paint nextCirclePaint;

  @override
  void paint(Object canvas, Size size) {}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
