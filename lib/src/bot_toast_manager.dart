import 'package:bot_toast/src/toast_widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.ensureVisualUpdate();
}

class BotToastManager extends StatefulWidget {
  final Widget child;

  const BotToastManager({Key key, this.child}) : super(key: key);

  @override
  BotToastManagerState createState() => BotToastManagerState();
}

class BotToastManagerState extends State<BotToastManager> {
  final Map<String, Map<UniqueKey, Widget>> _map = {};

  List<Widget> get _children =>
      _map.values.fold([], (value, items) {
        return value..addAll(items.values);
      });

  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      _map[groupKey] ??= {};
      final uniqueKey = UniqueKey();
      widget = ProxyDispose(
        key: uniqueKey,
        child: widget,
        disposeCallback: () {
          _map[groupKey]?.remove(key);
        },
      );
      _map[groupKey][key] = widget;
      _update();
    });
  }

  void remove(String groupKey, UniqueKey key) {
    safeRun(() {
      _map[groupKey]?.remove(key);
      _update();
    });
  }

  void removeAll(String groupKey) {
    safeRun(() {
      _map[groupKey]?.clear();
      _update();
    });
  }

  void cleanAll() {
    safeRun(() {
      _map.clear();
      _update();
    });
  }

  void _update() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
      ]
        ..addAll(_children),
    );
  }
}
