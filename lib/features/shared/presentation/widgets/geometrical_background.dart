import 'dart:math';

import 'package:flutter/material.dart';

class GeometricalBackground extends StatefulWidget {
  final Widget child;

  const GeometricalBackground({super.key, required this.child});

  @override
  State<GeometricalBackground> createState() => _GeometricalBackgroundState();
}

class _GeometricalBackgroundState extends State<GeometricalBackground> {
  late Size size;
  late double borderSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    size = MediaQuery.of(context).size;
    borderSize = size.width / 7;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final shapeWidgets = [
      _Circle(borderSize),
      _Square(borderSize),
      _Diamond(borderSize),
      _LeftTriangle(borderSize),
      _RightTriangle(borderSize),
      _SemiCircle(borderSize),
      _SemiCircleInverted(borderSize),
    ];

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            height: size.height * 0.7,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color(0xffECBFC4),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final availableHeight = size.height * 0.7;
                final rowHeight = borderSize;
                final numberOfRows = (availableHeight / rowHeight).floor();

                return Column(
                    children: List.generate(
                  numberOfRows,
                  (_) => ShapeRow(shapeWidgets: shapeWidgets),
                ));
              },
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}

class ShapeRow extends StatefulWidget {
  final List<Widget> shapeWidgets;

  const ShapeRow({Key? key, required this.shapeWidgets}) : super(key: key);

  @override
  State<ShapeRow> createState() => _ShapeRowState();
}

class _ShapeRowState extends State<ShapeRow> {
  late List<Widget> shapeMixedUp;

  @override
  void initState() {
    super.initState();
    shapeMixedUp = [...widget.shapeWidgets];
    shapeMixedUp.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    shapeMixedUp = [...widget.shapeWidgets];
    shapeMixedUp.shuffle();

    return Row(
      children: shapeMixedUp,
    );
  }
}

class _Circle extends StatelessWidget {
  final double borderSize;
  const _Circle(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: borderSize,
      height: borderSize,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffCFA4A9)),
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

class _Square extends StatelessWidget {
  final double borderSize;
  const _Square(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: borderSize,
      height: borderSize,
      decoration: BoxDecoration(
          border: Border.all(
        color: const Color(0xffCFA4A9),
      )),
    );
  }
}

class _RightTriangle extends StatelessWidget {
  final double borderSize;
  const _RightTriangle(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: borderSize,
      height: borderSize,
      child: CustomPaint(
        painter: _RightTrianglePainter(),
      ),
    );
  }
}

class _RightTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffCFA4A9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_RightTrianglePainter oldDelegate) => false;
}

class _LeftTriangle extends StatelessWidget {
  final double borderSize;
  const _LeftTriangle(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: borderSize,
      height: borderSize,
      child: CustomPaint(
        painter: _LeftTrianglePainter(),
      ),
    );
  }
}

class _LeftTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffCFA4A9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LeftTrianglePainter oldDelegate) => false;
}

class _Diamond extends StatelessWidget {
  final double borderSize;
  const _Diamond(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: borderSize,
      height: borderSize,
      child: CustomPaint(
        painter: _DiamondPainter(),
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffCFA4A9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(0, size.height * 0.5)
      ..lineTo(size.width * 0.5, size.height)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(size.width * 0.5, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_DiamondPainter oldDelegate) => false;
}

class _SemiCircle extends StatelessWidget {
  final double borderSize;
  const _SemiCircle(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: borderSize,
      height: borderSize,
      child: CustomPaint(
        painter: _SemiCirclePainter(),
      ),
    );
  }
}

class _SemiCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffCFA4A9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path
      ..addArc(
        Rect.fromCenter(
            center: Offset(size.height * 0.5, size.width * 0.5),
            width: size.width,
            height: size.height),
        pi,
        pi,
      )
      ..lineTo(0, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SemiCirclePainter oldDelegate) => false;
}

class _SemiCircleInverted extends StatelessWidget {
  final double borderSize;
  const _SemiCircleInverted(this.borderSize);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: borderSize,
      height: borderSize,
      child: CustomPaint(
        painter: _SemiCircleInvertedPainter(),
      ),
    );
  }
}

class _SemiCircleInvertedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffCFA4A9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();

    path
      ..addArc(
          Rect.fromCenter(
              center: Offset(size.height * 0.5, size.width * 0.5),
              width: size.width,
              height: size.height),
          pi,
          -pi)
      ..lineTo(0, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_SemiCircleInvertedPainter oldDelegate) => false;
}
