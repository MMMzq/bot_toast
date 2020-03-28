import 'package:flutter/material.dart';

import 'basis.dart';
import 'bot_toast_manager.dart';

final GlobalKey<BotToastInitState> _botToastInitKey =
GlobalKey<BotToastInitState>();

BotToastManager get botToastManager {
  assert(_botToastInitKey?.currentState?._botToastManager != null);
  return _botToastInitKey.currentState._botToastManager;
}

BotToastInitState get botToastInitState {
  assert(_botToastInitKey?.currentState?._botToastManager != null);
  return _botToastInitKey.currentState;
}

class BotToastInit extends StatefulWidget {
  final Widget child;

  BotToastInit({@required this.child})
      : assert(child != null),
        super(key: _botToastInitKey);

  @override
  BotToastInitState createState() => BotToastInitState();
}

class BotToastInitState extends State<BotToastInit>
    with WidgetsBindingObserver {
  bool _needInit;
  bool get needInit => _needInit;

  BotToastManager _botToastManager;
  List<PopTestFunc> _listener;


  VoidCallback registerPopListener(PopTestFunc popTestFunc) {
    assert(_listener != null);
    _listener.add(popTestFunc);
    return () {
      _listener.remove(popTestFunc);
    };
  }

  @override
  Future<bool> didPopRoute() async {
    final clone = _listener.reversed.toList(growable: false);
    for (PopTestFunc popTest in clone) {
      if (popTest())
        return true;
    }
    return super.didPopRoute();
  }

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
    _listener = <PopTestFunc>[];
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _botToastManager.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(BotToastInit oldWidget) {
    _needInit = true;
    super.didUpdateWidget(oldWidget);
  }
}
