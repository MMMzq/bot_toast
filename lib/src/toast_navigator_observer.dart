import 'package:flutter/material.dart';
class BotToastNavigatorObserver extends NavigatorObserver{
  final List<VoidCallback> _leavePageCallbacks=[];
  static final instance =BotToastNavigatorObserver._();

  bool debugInitialization=false;

  factory BotToastNavigatorObserver(){
    assert((){
      instance.debugInitialization=true;
      return true;
    }());
    return instance;
  }

  void runOnce(VoidCallback leavePageCallback){
    assert(debugInitialization,
    """
    Please initialize!
    Example:
    MaterialApp(
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Flutter Demo',
      home: ToastWidget(
        child: XxxxPage(title: 'Flutter Demo Home Page'),
      ),
    );
    """);
    VoidCallback voidCallback;
    voidCallback = (){
      leavePageCallback();
      _leavePageCallbacks.remove(voidCallback);
    };
    _leavePageCallbacks.add(voidCallback);
  }

  BotToastNavigatorObserver._();

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList();
    for(VoidCallback callback in copy){
        callback();
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    final copy = _leavePageCallbacks.toList();
    for(VoidCallback callback in copy){
      callback();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList();
    for(VoidCallback callback in copy){
      callback();
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList();
    for(VoidCallback callback in copy){
      callback();
    }
  }
}
