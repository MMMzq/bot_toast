import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackingToastsContainer extends StatefulWidget {
  const StackingToastsContainer({
    Key key,
    this.alignment,
    this.firstToast,
  }) : super(key: key);
  final Widget firstToast;
  final MainAxisAlignment alignment;

  @override
  State<StatefulWidget> createState() {
    return StackingToastsContainerState();
  }
}

class StackingToastsContainerState extends State<StackingToastsContainer> {
  final List<Widget> _toasts = <Widget>[];

  @override
  void initState() {
    _toasts.add(widget.firstToast);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top + 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _toasts,
          ),
        ),
      ),
    );
  }

  Map<Widget, Key> toastKeyMap = <Widget, Key>{};

  void addToast(
    Widget toast,
  ) {
    setState(() {
      _toasts.insert(0, toast);
    });
  }

  void removeToast(Widget toast) {
    setState(() {
      _toasts.remove(toast);
    });
  }

  bool get hasNoToast => _toasts.isEmpty;
}

enum StackingToastLevel {
  normal,
  accent,
  danger,
}

class StackingToast extends StatefulWidget {
  const StackingToast({
    Key key,
    this.icon,
    this.title,
    this.message,
    this.level = StackingToastLevel.normal,
    this.borderRadius,
    this.backgroundColor,
    this.textStyle,
    this.bodyPadding,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String message;
  final StackingToastLevel level;
  final BorderRadiusGeometry borderRadius;
  final Color backgroundColor;
  final TextStyle textStyle;
  final EdgeInsetsGeometry bodyPadding;

  @override
  State<StatefulWidget> createState() {
    return _StackingToastState();
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '$level $title $message';
  }
}

class _StackingToastState extends State<StackingToast> {
  @override
  Widget build(BuildContext context) {
    final double fontSize = widget.textStyle?.fontSize ??
        Theme.of(context).textTheme.bodyText2.fontSize;
    final Color fontColor = getFontColor();
    final TextStyle textStyle = widget.textStyle?.copyWith(inherit: false) ??
        TextStyle(
          fontSize: fontSize,
          color: fontColor,
          inherit: false,
        );
    final Color backgroundColor = widget.backgroundColor?.withAlpha(200) ??
        Theme.of(context).buttonColor.withAlpha(200);
    final Widget icon = getIcon(fontSize, fontColor);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).textTheme.bodyText2.fontSize * 4),
          padding: widget.bodyPadding ??
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    Text(
                      widget.title,
                      style: textStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(right: 8),
              ),
              Expanded(
                child: Text(
                  widget.message,
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getIcon(double iconSize, Color iconColor) {
    return widget.icon ??
        (widget.level == StackingToastLevel.normal
            ? Container(
                width: iconSize * 1.5,
                child: Icon(
                  Icons.info,
                  size: iconSize,
                  color: iconColor,
                ),
              )
            : widget.level == StackingToastLevel.accent
                ? Container(
                    width: iconSize * 1.5,
                    child: Icon(
                      Icons.check_circle,
                      size: iconSize,
                      color: iconColor,
                    ),
                  )
                : Container(
                    width: iconSize * 1.5,
                    child: Icon(
                      Icons.warning,
                      size: iconSize,
                      color: iconColor,
                    ),
                  ));
  }

  Color getFontColor() {
    return widget.level == StackingToastLevel.normal
        ? Theme.of(context).textTheme.bodyText2.color
        : widget.level == StackingToastLevel.accent
            ? Theme.of(context).primaryColor
            : Theme.of(context).errorColor;
  }
}
