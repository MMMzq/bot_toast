
import 'package:bot_toast/src/toast_widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'bot_toast_init.dart';

void safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.ensureVisualUpdate();
}

class BotToastManager {
  final Map<String, Map<UniqueKey, OverlayEntry>> _map = {};
  final BotToastInitState _botToastInitState;

  BotToastManager(this._botToastInitState);


  void dispose() {
    _children.forEach((item) {
      item.remove();
    });
    _map.clear();
  }

  List<OverlayEntry> get _children =>
      _map.values.fold([], (value, items) {
        return value..addAll(items.values);
      });

  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      assert(_botToastInitState != null);
      _map[groupKey] ??= {};
      final uniqueKey = UniqueKey();
      final overlayEntry = OverlayEntry(builder: (_) =>
          ProxyDispose(key: uniqueKey, child: widget, disposeCallback: () {
            _map[groupKey]?.remove(key);
          },));
      _map[groupKey][key] = overlayEntry;
      _botToastInitState.insert(overlayEntry);
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


