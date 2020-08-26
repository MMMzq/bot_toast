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

  final Set<UniqueKey> _pending = Set<UniqueKey>();

  List<Widget> get _children => _map.values.fold([], (value, items) {
        return value..addAll(items.values);
      });

  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      _map[groupKey] ??= {};
      final uniqueKey = UniqueKey();

      widget = ProxyInitState(
        initStateCallback: () {
          _pending.remove(key);
        },
        child: widget,
      );

      widget = ProxyDispose(
        key: uniqueKey,
        child: widget,
        disposeCallback: () {
          _map[groupKey]?.remove(key);
        },
      );
      _map[groupKey][key] = widget;
      _pending.add(key);
      _update();
    });
  }

  void remove(String groupKey, UniqueKey key) {
    safeRun(() {
      if (_pending.contains(key)) {
        //首桢渲染完成之前,就被删除,需要确保ProxyDispose被安装,因此要放到下一帧进行删除
        return remove(groupKey, key);
      } else {
        _map[groupKey]?.remove(key);
        _update();
      }
    });
  }

  void removeAll(String groupKey) {
    safeRun(() {
      if (_map[groupKey] == null) {
        return;
      }

      _map[groupKey].removeWhere((key, _) => !_pending.contains(key));
      _update();

      if (_map[groupKey].isNotEmpty) {
        _map[groupKey].forEach((key, value) {
          return remove(groupKey, key);
        });
      }
    });
  }

  void cleanAll() {
    safeRun(() {
      _map.forEach((groupKey, value) {
        assert(value != null);
        value.removeWhere((key, _) => !_pending.contains(key));

        if (value.isNotEmpty) {
          value.forEach((key, value) {
            return remove(groupKey, key);
          });
        }
      });
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
      ]..addAll(_children),
    );
  }
}
