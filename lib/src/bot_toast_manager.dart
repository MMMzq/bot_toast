import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'toast_widget/toast_widget.dart';

void safeRun(void Function() callback) {
  //Compatible with flutter 3.x
  final SchedulerBinding instance = SchedulerBinding.instance as dynamic;
  instance.addPostFrameCallback((_) {
    callback();
  });
  instance.ensureVisualUpdate();
}

class BotToastManager extends StatefulWidget {
  final Widget child;

  const BotToastManager({required this.child, Key? key}) : super(key: key);

  @override
  BotToastManagerState createState() => BotToastManagerState();
}

class _IndexWidget extends StatelessWidget {
  final Widget child;

  final int index;

  const _IndexWidget({required this.child, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class BotToastManagerState extends State<BotToastManager> {
  final Map<String, Map<UniqueKey, _IndexWidget>> _map = <String, Map<UniqueKey, _IndexWidget>>{};

  final Set<UniqueKey> _pending = <UniqueKey>{};

  int _nextAddIndex = 0;

  List<_IndexWidget> get _children => _map.values.fold<List<_IndexWidget>>(<_IndexWidget>[],
          (List<_IndexWidget> value, Map<UniqueKey, _IndexWidget> items) {
        return value..addAll(items.values);
      })
        ..sort((_IndexWidget a, _IndexWidget b) => a.index.compareTo(b.index));

  void insert(String groupKey, UniqueKey key, Widget widget) {
    safeRun(() {
      _map[groupKey] ??= <UniqueKey, _IndexWidget>{};
      final UniqueKey uniqueKey = UniqueKey();

      widget = ProxyInitState(
        initStateCallback: () {
          _pending.remove(key);
        },
        child: widget,
      );

      widget = ProxyDispose(
        child: widget,
        disposeCallback: () {
          _map[groupKey]?.remove(key);
        },
      );
      _map[groupKey]![key] = _IndexWidget(
        key: uniqueKey,
        index: ++_nextAddIndex,
        child: widget,
      );
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

      _map[groupKey]!.removeWhere((UniqueKey key, _) => !_pending.contains(key));
      _update();

      _map[groupKey]!.forEach((UniqueKey key, _IndexWidget value) {
        return remove(groupKey, key);
      });
    });
  }

  void cleanAll() {
    safeRun(() {
      _map.forEach((String groupKey, Map<UniqueKey, _IndexWidget> value) {
        value.removeWhere((UniqueKey key, _) => !_pending.contains(key));

        if (value.isNotEmpty) {
          value.forEach((UniqueKey key, _IndexWidget value) {
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
        ..._children,
      ],
    );
  }
}
