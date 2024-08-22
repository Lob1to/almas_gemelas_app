import 'package:flutter/material.dart';

class PushableText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const PushableText({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.size = 17,
    this.fontWeight = FontWeight.w500,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );

    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(text, style: style, textAlign: textAlign),
      ),
    );
  }
}
