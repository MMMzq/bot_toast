import 'package:flutter/material.dart';


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
class BotToastNavigatorObserver extends NavigatorObserver{
  final List<VoidCallback> _leavePageCallbacks=[];
  static final instance =BotToastNavigatorObserver._();

  factory BotToastNavigatorObserver(){
    return instance;
  }

  void runOnce(VoidCallback leavePageCallback){

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
