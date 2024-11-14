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
    WidgetsBinding.instance.addObserver(this);
  }

  final List<PopTestFunc> _listener;

  static final BotToastWidgetsBindingObserver _singleton = BotToastWidgetsBindingObserver._();

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
      final List<PopTestFunc> clone = _listener.reversed.toList(growable: false);
      for (PopTestFunc popTest in clone) {
        if (popTest()) {
          return true;
        }
      }
    }
    return super.didPopRoute();
  }
}

class BotToastBuilder extends StatelessWidget {
  final Widget child;

  const BotToastBuilder({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final observer = BotToastWidgetsBindingObserver._singleton;

    return BotToastManager(
      key: _key,
      child: child,
    );
  }
}
