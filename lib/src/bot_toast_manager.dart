
import 'package:bot_toast/src/toast_widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../bot_toast.dart';
import 'bot_toast_init.dart';

void safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.ensureVisualUpdate();
}

class BotToastManager {
  final Map<String, Map<UniqueKey, OverlayEntry>> _map = {};
  NavigatorState _navigatorState;
  BotToastNavigatorObserverProxy _observerProxy;
  BotToastInitState botToastInitState;

  BotToastManager(this.botToastInitState);


  void dispose() {
    if (_observerProxy != null) {
      BotToastNavigatorObserver.unregister(_observerProxy);
    }
    _children.forEach((item) {
      item.remove();
    });
    _map.clear();
  }


  ///需要监听didPush是因为,当Navigator的Route集合为空再推一个Route会导致这个页面覆盖_BotToastManager上面,挡住了Toast,因此要手动移动到最后
  ///在1.7.8版本以下,一般是在使用[Navigator.pushAndRemoveUntil]才可能发生这种情况
  void _checkNavigatorState(BuildContext context) {
    assert(BotToastNavigatorObserver.debugInitialization, """
    Please initialize properly!
    Example:
    BotToastInit(
      child: MaterialApp(
        title: 'BotToast Demo',
        navigatorObservers: [BotToastNavigatorObserver()],
        home: XxxPage()
      ),
    );
    """);

    void visitor(Element element) {
      assert(() {
        if (element.widget is Localizations &&
            ((element as StatefulElement).state as dynamic).locale == null) {
          return false;
        }
        return true;
      }(), 'Initialization error : locale==null');
      if (element.widget is Navigator) {
        if (_navigatorState == null ||
            _navigatorState != (element as StatefulElement).state) {
          _navigatorState = (element as StatefulElement).state;
        }
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(_navigatorState != null, '''
         Initialization error.
         The initialization method has been modified in version 2.0.
         do you wrapped you app widget like this?
         
         BotToastInit(
               child: MaterialApp(
                 navigatorObservers: [BotToastNavigatorObserver()],
                 home: XxxPage(),
               ),
             );
      ''');


    if (_observerProxy == null) {
      _observerProxy = BotToastNavigatorObserverProxy(
        didPush: (route, _) {
          if (route.isFirst) {
            safeRun(() {
              if (_children.isNotEmpty) {
                _navigatorState.overlay
                    .rearrange(_children, below: _children.first);
              }
            });
          }
        },
      );
      BotToastNavigatorObserver.register(_observerProxy);
    }
  }

  List<OverlayEntry> get _children =>
      _map.values.fold([], (value, items) {
        return value..addAll(items.values);
      });


  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      assert(botToastInitState != null);
      _map[groupKey] ??= {};
      final uniqueKey = UniqueKey();
      final overlayEntry = OverlayEntry(builder: (_) =>
          ProxyDispose(key: uniqueKey, child: widget, disposeCallback: () {
            _map[groupKey]?.remove(key);
          },));
      _map[groupKey][key] = overlayEntry;
      if (botToastInitState.needInit) {
        botToastInitState.reset();
        _checkNavigatorState(botToastInitState.context);
      }
      _navigatorState.overlay.insert(overlayEntry);
    });
  }

  void remove(String groupKey, UniqueKey key) {
    safeRun(() {
      final result = _map[groupKey]?.remove(key);
      if (result != null) {
        result.remove();
      }
    });
  }

  void removeAll(String groupKey) {
    safeRun(() {
      _map[groupKey]?.forEach((key, value) {
        assert(value != null);
        value.remove();
      });
      _map[groupKey]?.clear();
    });
  }

  void cleanAll() {
    safeRun(() {
      List<OverlayEntry> children = _children;
      assert(children.every((test) => test != null));
      children.forEach((item) {
        item.remove();
      });
      _map.clear();
    });
  }
}


