import 'package:flutter/material.dart';

final GlobalKey<_BotToastInitState> botToastInitKey =
GlobalKey<_BotToastInitState>();

class BotToastInit extends StatefulWidget {
  final Widget child;

  BotToastInit({@required this.child})
      : assert(child != null),
        super(key: botToastInitKey);

  @override
  _BotToastInitState createState() => _BotToastInitState();
}

class _BotToastInitState extends State<BotToastInit> {
  bool _needInit;

  bool get needInit => _needInit;

  void reset() {
    _needInit = false;
  }

  @override
  Widget build(BuildContext context) {
    _needInit = true;
    return widget.child;
  }

  @override
  void initState() {
    _needInit = true;
    super.initState();
  }

  @override
  void didUpdateWidget(BotToastInit oldWidget) {
    _needInit = true;
    super.didUpdateWidget(oldWidget);
  }
}
