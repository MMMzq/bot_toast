import 'package:flutter/material.dart';

class BotToastManager extends StatefulWidget {
  const BotToastManager({Key key}) : super(key: key);

  @override
  BotToastManagerState createState() => BotToastManagerState();
}

class BotToastManagerState extends State<BotToastManager> {
  final Map<String, Map<UniqueKey, IndexedSemantics>> _map = {};
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<IndexedSemantics> children = _map.values.fold([], (value, items) {
      return value..addAll(items.values);
    });
    children.sort((a, b) => a.index.compareTo(b.index));
    return Stack(children: children);
  }

  ///这里不使用传进来的key,是因为该key在这里担当的是一个UUid的职责,
  ///不应该用在widget里面,
  ///那为什么有需要自己new 一个UniqueKey()
  ///这表明这个Widget在这里面是独一无二的,
  ///这会防止一些隐晦的bug,
  ///例如:如果不加入该UniqueKey将会导致
  ///[BotToast.showEnhancedWidget]onlyOne功能失效,
  ///主要是因为flutter,只是根据runtimeType来进行判断的话
  ///会导致调错了各个Toast的dispose
  void insert(String groupKey, UniqueKey key, Widget widget) {
    setState(() {
      _map[groupKey] ??= {};
      _map[groupKey][key] = IndexedSemantics(
        index: index++,
        child: widget,
        key: UniqueKey(),
      );
    });
  }

  void remove(String groupKey, UniqueKey key) {
    setState(() {
      _map[groupKey]?.remove(key);
    });
  }

  void removeAll(String groupKey) {
    setState(() {
      _map[groupKey]?.clear();
    });
  }

  void cleanAll() {
    setState(() {
      _map.clear();
    });
  }
}
