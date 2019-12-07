import 'package:flutter/material.dart';

import 'bot_toast_manager.dart';

final GlobalKey<BotToastInitState> _botToastInitKey =
GlobalKey<BotToastInitState>();

BotToastManager get botToastManager {
  assert(_botToastInitKey?.currentState?._botToastManager != null);
  return _botToastInitKey.currentState._botToastManager;
}

class BotToastInit extends StatefulWidget {
  final Widget child;

  BotToastInit({@required this.child})
      : assert(child != null),
        super(key: _botToastInitKey);

  @override
  BotToastInitState createState() => BotToastInitState();
}

class BotToastInitState extends State<BotToastInit> {
  bool _needInit;
  bool get needInit => _needInit;

  BotToastManager _botToastManager;

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
    _botToastManager = BotToastManager(this);
    super.initState();
  }

  @override
  void dispose() {
    _botToastManager.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BotToastInit oldWidget) {
    _needInit = true;
    super.didUpdateWidget(oldWidget);
  }
}
