part of 'toast.dart';

class _BotToastManager extends StatefulWidget {
  _BotToastManager({Key key}) : super(key: key);

  @override
  _BotToastManagerState createState() => _BotToastManagerState();
}

class _BotToastManagerState extends State<_BotToastManager> {
  Map<String, Map<UniqueKey, Widget>> _map = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: _map.values.fold([], (value, items) {
          return value..addAll(items.values);
        }));
  }

  void insert(String groupKey, UniqueKey key, Widget widget) {
    setState(() {
      _map[groupKey] ??= {};
      _map[groupKey][key] = widget;
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