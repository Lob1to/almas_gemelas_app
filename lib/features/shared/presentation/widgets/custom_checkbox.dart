import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final double size;
  final Color color;
  final bool value;
  final Function(bool?) onChanged;
  const CustomCheckbox(
      {super.key,
      required this.size,
      required this.color,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(size * 0.15);

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: value ? color : const Color.fromARGB(58, 24, 30, 34)),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Center(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => onChanged(value),
            child: Container(
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                color: value ? color : Colors.transparent,
                borderRadius: radius,
              ),
              child: CustomPaint(
                painter: CustomCheckPainter(
                  isChecked: value,
                  checkColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheckPainter extends CustomPainter {
  final bool isChecked;
  final Color checkColor;

  CustomCheckPainter({required this.isChecked, required this.checkColor});

  @override
  void paint(Canvas canvas, Size size) {
    if (isChecked) {
      final paint = Paint()
        ..color = checkColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      final path = Path()
        ..moveTo(size.width * 0.3, size.height * 0.5)
        ..lineTo(size.width * 0.45, size.height * 0.65)
        ..lineTo(size.width * 0.7, size.height * 0.3);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomCheckPainter oldDelegate) {
    return isChecked != oldDelegate.isChecked;
  }
}
