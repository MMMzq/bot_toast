import 'package:flutter/material.dart';

import 'basis.dart';
import 'bot_toast_manager.dart';

final GlobalKey<BotToastInitState> _botToastInitKey =
GlobalKey<BotToastInitState>();

BotToastManager get botToastManager {
  assert(_botToastInitKey?.currentState?._botToastManager != null);
  return _botToastInitKey.currentState._botToastManager;
}


class BotToastWidgetsBindingObserver with WidgetsBindingObserver {

  BotToastWidgetsBindingObserver._(){
    _listener = <PopTestFunc>[];
    WidgetsBinding.instance.addObserver(this);
  }

  List<PopTestFunc> _listener;

  static final BotToastWidgetsBindingObserver _singleton = BotToastWidgetsBindingObserver
      ._();

  static BotToastWidgetsBindingObserver get singleton => _singleton;


  VoidCallback registerPopListener(PopTestFunc popTestFunc) {
    assert(_listener != null);
    _listener.add(popTestFunc);
    return () {
      _listener.remove(popTestFunc);
    };
  }

  @override
  Future<bool> didPopRoute() async {
    if (_listener.isNotEmpty) {
      final clone = _listener.reversed.toList(growable: false);
      for (PopTestFunc popTest in clone) {
        if (popTest()) return true;
      }
    }
    return super.didPopRoute();
  }

}

// ignore: non_constant_identifier_names
TransitionBuilder BotToastInit() {
  //确保提前初始化,保证WidgetsBinding.instance.addObserver(this);的顺序
  BotToastWidgetsBindingObserver._singleton;
  return (_, Widget child) {
    return _BotToastInit(child: child);
  };
}

class _BotToastInit extends Overlay {
  final Widget child;

  _BotToastInit({@required this.child})
      : assert(child != null),
        super(key: _botToastInitKey,
          initialEntries: [
            OverlayEntry(maintainState: true, builder: (_) => child)
          ]);

  @override
  BotToastInitState createState() => BotToastInitState();
}

class BotToastInitState extends OverlayState {

  BotToastManager _botToastManager;

  @override
  void initState() {
    super.initState();
    _botToastManager = BotToastManager(this);
  }

  @override
  void dispose() {
    super.dispose();
    _botToastManager.dispose();
  }

}
