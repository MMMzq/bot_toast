import 'package:flutter/material.dart';
export 'animation.dart';
export 'attached.dart';
export 'loading.dart';
export 'notification.dart';
export 'text.dart';

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose({
    Key key,
    @required this.disposeCallback,
    @required this.child,
  })  : assert(child != null),
        assert(disposeCallback != null),
        super(key: key);

  @override
  _ProxyDisposeState createState() => _ProxyDisposeState();
}

class _ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}
