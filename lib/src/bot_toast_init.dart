import 'package:flutter/material.dart';

import 'basis.dart';
import 'bot_toast_manager.dart';

final GlobalKey<BotToastManagerState> _key = GlobalKey<BotToastManagerState>();

BotToastManagerState get botToastManager {
  assert(_key.currentState != null);
  return _key.currentState!;
}

class BotToastWidgetsBindingObserver with WidgetsBindingObserver {
  BotToastWidgetsBindingObserver._() : _listener = <PopTestFunc>[] {
    //Compatible with flutter 3.x
    (WidgetsBinding.instance as dynamic).addObserver(this);
  }

  final List<PopTestFunc> _listener;

  static final BotToastWidgetsBindingObserver _singleton =
      BotToastWidgetsBindingObserver._();

  static BotToastWidgetsBindingObserver get singleton => _singleton;

  VoidCallback registerPopListener(PopTestFunc popTestFunc) {
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

  //ignore: unnecessary_statements
  BotToastWidgetsBindingObserver._singleton;
  return (_, Widget? child) {
    return BotToastManager(key: _key, child: child!);
  };
}
