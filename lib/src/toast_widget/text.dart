import 'package:flutter/material.dart';

//文本提示的Widget
class TextToast extends StatefulWidget {
  final String text;
  final EdgeInsetsGeometry? contentPadding;
  final Color? contentColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? textStyle;

  const TextToast({
    Key? key,
    required this.text,
    this.contentPadding,
    this.contentColor,
    this.borderRadius,
    this.textStyle,
  }) : super(key: key);

  @override
  TextToastState createState() => TextToastState();
}

class TextToastState extends State<TextToast> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
            constraints:
                constraints.copyWith(maxWidth: constraints.biggest.width * 0.6),
            padding: widget.contentPadding,
            decoration: BoxDecoration(
              color: widget.contentColor,
              borderRadius: widget.borderRadius,
            ),
            child: Text(
              widget.text,
              style: widget.textStyle,
              textAlign: TextAlign.center,
            ));
      },
    );
  }
}
