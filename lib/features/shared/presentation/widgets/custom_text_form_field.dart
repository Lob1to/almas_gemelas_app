import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String formTitle;
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final bool showVisibilityButton;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function? passwordVisibilityCallback;

  const CustomTextFormField({
    super.key,
    this.formTitle = '',
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.passwordVisibilityCallback,
    this.showVisibilityButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(185, 148, 151, 159), width: 0.5),
        borderRadius: BorderRadius.circular(15));
    const style = TextStyle(
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: Color.fromARGB(166, 148, 151, 159));

    const titleStyle = TextStyle(
      fontFamily: 'Satoshi',
      fontWeight: FontWeight.w700,
      fontSize: 17,
      color: Colors.black,
    );

    return Column(
      children: [
        (formTitle != '')
            ? Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '   $formTitle',
                      style: titleStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : const SizedBox(height: 0),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffF9F9F9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ]),
          child: TextFormField(
            onChanged: onChanged,
            validator: validator,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(fontSize: 20, color: Colors.black),
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff94979F))),
              floatingLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
              contentPadding: const EdgeInsets.only(
                  left: 30, right: 16, top: 20, bottom: 12),
              enabledBorder: border,
              focusedBorder: border.copyWith(
                borderSide: BorderSide(color: colors.outlineVariant),
              ),
              errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.transparent)),
              focusedErrorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.transparent)),
              isDense: true,
              label: label != null ? Text(label!, style: style) : null,
              hintText: hint,
              hintStyle: style,
              errorText: errorMessage,
              focusColor: colors.primary,
              suffixIcon: (showVisibilityButton)
                  ? GestureDetector(
                      onTap: () {
                        (passwordVisibilityCallback != null)
                            ? passwordVisibilityCallback!()
                            : null;
                      },
                      child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: (obscureText)
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Color(0xff94979F),
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Color(0xff94979F),
                                )),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
