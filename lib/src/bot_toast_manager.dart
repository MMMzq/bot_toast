part of 'toast.dart';

class _BotToastManager extends StatefulWidget {
  _BotToastManager({Key key}) : super(key: key);

  @override
  _BotToastManagerState createState() => _BotToastManagerState();
}

class _BotToastManagerState extends State<_BotToastManager> {
  Map<String, Map<UniqueKey, IndexedSemantics>> _map = {};
  int index=0;

  @override
  Widget build(BuildContext context) {
    List<IndexedSemantics> children = _map.values.fold([], (value, items) {
      return value..addAll(items.values);
    });
    children.sort((a,b)=>a.index.compareTo(b.index));
    return Stack(
        children: children);
  }

  void insert(String groupKey, UniqueKey key, Widget widget) {
    setState(() {
      _map[groupKey] ??= {};
      _map[groupKey][key] = IndexedSemantics(index: index++,child: widget,);
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