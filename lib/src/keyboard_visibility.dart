import 'package:flutter/material.dart';

class KeyboardVisibility extends StatefulWidget {
  final void Function(bool open) onKeyboardVisibilityChanged;
  final Widget child;

  const KeyboardVisibility(
      {required this.onKeyboardVisibilityChanged,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  _KeyboardVisibilityState createState() => _KeyboardVisibilityState();
}

class _KeyboardVisibilityState extends State<KeyboardVisibility>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      widget.onKeyboardVisibilityChanged(false);
    } else {
      widget.onKeyboardVisibilityChanged(true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
