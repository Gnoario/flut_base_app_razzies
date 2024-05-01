import 'package:flut_base_app_razzies/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  const BaseText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        overflow: overflow,
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color ?? context.appColors.brandSecondary.black,
      ),
    );
  }
}
