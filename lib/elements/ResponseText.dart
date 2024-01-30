import 'package:flutter/material.dart';

class ResponsiveText extends StatefulWidget {
  final String text;
  final FontSizeRange fontSizeRange;
  final Color color;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  //final FontFamily? fontFamily;
  final double letterSpacing;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final double lineHeight;
  final TextOverflow overflow;
  final bool softWrap;
  final int maxLines;
  final TextStyle style;

  ResponsiveText({
    required this.text,
    required this.fontSizeRange,
    this.color = Colors.black,
    this.fontStyle,
    this.fontWeight,
    //this.fontFamily,
    this.letterSpacing = 0.0,
    this.textDecoration,
    this.textAlign,
    this.lineHeight = 1.0,
    this.overflow = TextOverflow.clip,
    this.softWrap = true,
    this.maxLines = 2147483647, // Int.MAX_VALUE
    required this.style,
  });

  @override
  _ResponsiveTextState createState() => _ResponsiveTextState();
}

class _ResponsiveTextState extends State<ResponsiveText> {
  double fontSizeValue = 0.0;
  bool readyToDraw = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Text(
          widget.text,
          style: widget.style.copyWith(fontSize: fontSizeValue),
          maxLines: widget.maxLines,
          overflow: fontSizeValue <= widget.fontSizeRange.min
              ? TextOverflow.ellipsis
              : widget.overflow,
          softWrap: widget.softWrap,
          textAlign: widget.textAlign,
        );
      },
    );
  }
}

class FontSizeRange {
  final double min;
  final double max;
  final double step;

  FontSizeRange({
    required this.min,
    required this.max,
    this.step = DEFAULT_TEXT_STEP,
  }) : assert(min < max, 'min should be less than max'),
        assert(step > 0, 'step should be greater than 0');

  static const double DEFAULT_TEXT_STEP = 1.0;
}