import 'package:flutter/material.dart';
export 'animation.dart';
export 'attached.dart';
export 'loading.dart';
export 'notification.dart';
export 'text.dart';

class ProxyInitState extends StatefulWidget {
  final Widget child;
  final VoidCallback initStateCallback;

  const ProxyInitState({Key? key,required this.initStateCallback,required this.child})
      : super(key: key);

  @override
  _ProxyInitStateState createState() => _ProxyInitStateState();
}

class _ProxyInitStateState extends State<ProxyInitState> {
  @override
  void initState() {
    widget.initStateCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose({
    Key? key,
    required this.disposeCallback,
    required this.child,
  })  : super(key: key);

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
