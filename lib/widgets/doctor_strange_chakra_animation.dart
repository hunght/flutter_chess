import 'package:flutter/material.dart';
import 'dart:math' as math;

class DoctorStrangeChakra extends StatefulWidget {
  @override
  _DoctorStrangeChakraState createState() => _DoctorStrangeChakraState();
}

class _DoctorStrangeChakraState extends State<DoctorStrangeChakra>
    with TickerProviderStateMixin {
  AnimationController _circleController;
  AnimationController _squareController;

  @override
  void initState() {
    super.initState();
    _circleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _squareController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true, period: Duration(seconds: 3));
  }

  @override
  void dispose() {
    _circleController.dispose();
    _squareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
        Colors.orange[800].withOpacity(0.5),
        Colors.black.withOpacity(.2)
      ])),
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: <Widget>[
              CustomPaint(
                painter: _ChakraPainter(
                    CurvedAnimation(
                        parent: _circleController, curve: Curves.ease),
                    CurvedAnimation(
                        parent: _squareController, curve: Curves.ease)),
                size: Size.infinite,
              ),
              Transform.rotate(
                angle: 150,
                child: CustomPaint(
                  painter: _RotatedSquare(CurvedAnimation(
                      parent: _squareController, curve: Curves.ease)),
                  size: Size.infinite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChakraPainter extends CustomPainter {
  final Animation<double> circleAnimation;
  final Animation<double> squareAnimation;
  final int count;
  final Paint circlePaint;

  _ChakraPainter(
    this.circleAnimation,
    this.squareAnimation, {
    this.count = 7,
  })  : circlePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = Colors.orange[700]
          ..blendMode = BlendMode.screen,
        super(repaint: circleAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide * 0.30) * circleAnimation.value;
    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.43);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.99;
      canvas.drawCircle(
          center + offset * circleAnimation.value, radius / 6, circlePaint);
    }

    canvas.drawCircle(
        center, squareAnimation.value * radius / 1.22, circlePaint);

    canvas.drawCircle(
        center, squareAnimation.value * radius / 2.5, circlePaint);

    canvas.drawRect(
        Rect.fromCenter(
          center: center,
          height: squareAnimation.value * 450,
          width: squareAnimation.value * 450,
        ),
        circlePaint);

    for (int index = 0; index < count; index++) {
      final indexAngle = (index * math.pi / count * 2);
      final angle = indexAngle + (math.pi * 1.43);
      final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.99;
      canvas.drawCircle(
          center + offset * circleAnimation.value, radius / 3, circlePaint);
    }
  }

  @override
  bool shouldRepaint(_ChakraPainter oldDelegate) =>
      circleAnimation != oldDelegate.circleAnimation;
}

class _RotatedSquare extends CustomPainter {
  final Animation<double> squareAnimation;
  final int count;
  final Paint circlePaint;

  _RotatedSquare(
    this.squareAnimation, {
    this.count = 7,
  })  : circlePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = Colors.orange[700]
          ..blendMode = BlendMode.screen,
        super(repaint: squareAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    canvas.drawRect(
        Rect.fromCenter(
          center: center,
          height: squareAnimation.value * 450,
          width: squareAnimation.value * 450,
        ),
        circlePaint);
  }

  @override
  bool shouldRepaint(_ChakraPainter oldDelegate) =>
      squareAnimation != oldDelegate.circleAnimation;
}
