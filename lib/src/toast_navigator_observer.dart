import 'package:flutter/material.dart';

class BotToastNavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didPush;
  void Function(Route<dynamic> newRoute, Route<dynamic> oldRoute) didReplace;
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didRemove;
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didPop;

  BotToastNavigatorObserverProxy(
  {this.didPush, this.didReplace, this.didRemove, this.didPop});

  BotToastNavigatorObserverProxy.all(VoidCallback leavePageCallback) {
    didPush = (_, __) => leavePageCallback();
    didReplace = (_, __) => leavePageCallback();
    didRemove = (_, __) => leavePageCallback();
    didPop = (_, __) => leavePageCallback();
  }
}

///如果你项目有多个[Navigator],请将该BotToastNavigatorObserver添加到[Navigator.observers]
///可以参考[BotToast.init]方法添加
///或者在创建[Navigator]时直接添加
///    Example:
///    MaterialApp(
///      navigatorObservers: [BotToastNavigatorObserver()],
///      title: 'Flutter Demo',
///      home: ToastWidget(
///        child: XxxxPage(title: 'Flutter Demo Home Page'),
///      ),
///    );
class BotToastNavigatorObserver extends NavigatorObserver {
  static final List<BotToastNavigatorObserverProxy> _leavePageCallbacks = [];

  static bool debugInitialization = false;

  BotToastNavigatorObserver() {
    assert(() {
      debugInitialization = true;
      return true;
    }());
  }

  static void register(BotToastNavigatorObserverProxy botToastNavigatorObserverProxy) {
    assert(debugInitialization, """
    Please initialize!
    Example:
    MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BotToastInit(child: EnterPage()),
    );
    """);
    assert(botToastNavigatorObserverProxy != null);
    _leavePageCallbacks.add(botToastNavigatorObserverProxy);
  }

  static void unregister(BotToastNavigatorObserverProxy botToastNavigatorObserverProxy) {
    assert(botToastNavigatorObserverProxy != null);
    _leavePageCallbacks.remove(botToastNavigatorObserverProxy);
  }

  BotToastNavigatorObserver._();

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (BotToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPush?.call(route,previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (BotToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didReplace?.call(newRoute,oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (BotToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didRemove?.call(route,previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (BotToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPop?.call(route,previousRoute);
    }
  }
}
