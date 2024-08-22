import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;

  const CustomFilledButton(
      {super.key, this.onPressed, required this.text, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: FilledButton(
          style: FilledButton.styleFrom(
              backgroundColor: buttonColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'Satoshi', fontSize: 20, color: Colors.white),
          )),
    );
  }
}
